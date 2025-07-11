public class AccountTriggerHandler {
    public static void handleAfterInsertOrUpdate(Map<Id, Account> newAccountMap) {
        Set<Id> accountIds = newAccountMap.keySet();
        
        // Step 1: Query contacts outside the loop
        List<Contact> existingContacts = [
            SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds
        ];
        
        // Step 2: Build AccountId → Contact map
        Map<Id, Contact> accountToExistingContact = new Map<Id, Contact>();
        for (Contact con : existingContacts) {
            if (!accountToExistingContact.containsKey(con.AccountId)) {
                accountToExistingContact.put(con.AccountId, con);
            }
        }
        
        // Step 3: Create new contacts if needed
        List<Contact> contactsToInsert = new List<Contact>();
        for (Id accId : accountIds) {
            if (!accountToExistingContact.containsKey(accId)) {
                Account acc = newAccountMap.get(accId);
                contactsToInsert.add(new Contact(
                    FirstName = 'Auto',
                    LastName = acc.Name != null ? acc.Name : 'Generated',
                    Email = acc.Name != null ? acc.Name.replaceAll('\\s+', '') + '@example.com' : 'auto@example.com',
                    AccountId = accId
                ));
            }
        }
        
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
            for (Contact con : contactsToInsert) {
                accountToExistingContact.put(con.AccountId, con);
            }
        }
        
        // Step 4: Create Opportunities
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        Map<Id, Opportunity> accountToOpportunity = new Map<Id, Opportunity>();
        
        for (Id accId : accountToExistingContact.keySet()) {
            Account acc = newAccountMap.get(accId);
            Opportunity opp = new Opportunity(
                Name = 'Auto Opportunity - ' + acc.Name,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                AccountId = accId
            );
            opportunitiesToInsert.add(opp);
            accountToOpportunity.put(accId, opp);
        }
        
        if (!opportunitiesToInsert.isEmpty()) {
            insert opportunitiesToInsert;
        }
        
        // ✅ Step 5: Get Standard Pricebook manually
        Id standardPBId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;
        
        // ✅ Step 6: Get Product2 with valid PricebookEntry
        List<Product2> activeProducts = [
            SELECT Id, Name, IsActive,
            (SELECT Id, UnitPrice, Pricebook2Id FROM PricebookEntries WHERE IsActive = true AND Pricebook2Id = :standardPBId)
            FROM Product2
            WHERE IsActive = true
            LIMIT 1
        ];
        
        if (activeProducts.isEmpty() || activeProducts[0].PricebookEntries.isEmpty()) {
            System.debug('⚠️ No active product or matching PricebookEntry found.');
            return;
        }
        
        PricebookEntry pbe = activeProducts[0].PricebookEntries[0];
        
        // Step 7: Create Opportunity Line Items
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        for (Opportunity opp : opportunitiesToInsert) {
            oliList.add(new OpportunityLineItem(
                OpportunityId = opp.Id,
                Quantity = 1, 
                UnitPrice = pbe.UnitPrice,
                PricebookEntryId = pbe.Id
            ));
        }
      
        if (!oliList.isEmpty()) {
            insert oliList;
        }
    }
}