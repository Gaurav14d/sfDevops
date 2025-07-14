trigger DeleteContactsWithoutAccounts on Contact (after delete) {
    Set<Id> accountIds = new Set<Id>();
    
    for (Contact con : Trigger.old) {
        accountIds.add(con.AccountId);
    }
    
    List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE Id IN :Trigger.old AND AccountId = null];
    
    if (!contactsToDelete.isEmpty()) {
        delete contactsToDelete;
    }
}