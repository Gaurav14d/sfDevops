/*public class Accounttriggerhandlers {
public static void handleAfterUpdateActivities(List<Account> newAccount, Map<Id, Account> oldMap){
List<Account> accListtoUpdate = new List<Account>();
for(Account accObj : newAccount){
if(accObj.Website != oldMap.get(accObj.Id).Website){
accListtoUpdate.add(accObj);
}
}
}
}*/
public class AccountTriggerHandlers {
    public static void updateContactsWebsites(Map<Id, Account> newAccountsMap, Map<Id, Account> oldAccountsMap) {
        Set<Id> accountIdsToUpdate = new Set<Id>();
        Map<Id, String> accountIdToNewWebsiteMap = new Map<Id, String>();
        
        for (Id accId : newAccountsMap.keySet()) {
            if (newAccountsMap.get(accId).Website != oldAccountsMap.get(accId).Website) {
                accountIdsToUpdate.add(accId);
                accountIdToNewWebsiteMap.put(accId, newAccountsMap.get(accId).Website);
            }
        }
        
        if (!accountIdsToUpdate.isEmpty()) {
            List<Contact> contactsToUpdate = new List<Contact>();
            
            
            List<Contact> relatedContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIdsToUpdate];
            
            
            for (Contact con : relatedContacts) {
                String newWebsite = accountIdToNewWebsiteMap.get(con.AccountId);
                if (newWebsite != null) {
                    con.Website__c = newWebsite;
                    contactsToUpdate.add(con);
                }
            }
            
            
            if (!contactsToUpdate.isEmpty()) {
                try {
                    update contactsToUpdate;
                } catch (DmlException e) {
                    System.debug('Error updating Contacts: ' + e.getMessage());
                }
            }
        }
    }
}