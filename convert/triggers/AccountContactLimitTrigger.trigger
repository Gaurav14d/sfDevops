trigger AccountContactLimitTrigger on Contact (before insert, before update) {
    // Set to keep track of Accounts and their associated contacts
    Map<Id, Integer> accountContactCount = new Map<Id, Integer>();
    
    // Collect Account Ids from the Contacts being inserted or updated
    for (Contact con : Trigger.new) {
        if (con.AccountId != null) {
            if (!accountContactCount.containsKey(con.AccountId)) {
                accountContactCount.put(con.AccountId, 0);
            }
            accountContactCount.put(con.AccountId, accountContactCount.get(con.AccountId) + 1);
        }
    }
    
    // Query the existing Contacts related to the Accounts in context
    List<Contact> existingContacts = [SELECT AccountId FROM Contact WHERE AccountId IN :accountContactCount.keySet()];
    
    // Count existing contacts per Account
    for (Contact existingContact : existingContacts) {
        if (accountContactCount.containsKey(existingContact.AccountId)) {
            accountContactCount.put(existingContact.AccountId, accountContactCount.get(existingContact.AccountId) + 1);
        }
    }
    
    // Check if any Account exceeds the contact limit
    for (Contact con : Trigger.new) {
        if (con.AccountId != null && accountContactCount.get(con.AccountId) > 2) {
            con.addError('An Account cannot have more than 2 Contacts.');
        }
    }
}