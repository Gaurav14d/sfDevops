public class AccountHandler {
    public static void updateContactTitles(List<Account> accounts) {
        Set<Id> accountIds = new Set<Id>();
        for (Account accObj : accounts) {
            if (accObj.Industry == 'Agriculture') {
                accountIds.add(accObj.Id);
            }
        }
        
        if (accountIds.isEmpty()) {
            return;
        }
        
        List<Contact> contactsToUpdate = [SELECT Id, Title FROM Contact WHERE AccountId IN :accountIds];
        
        for (Contact contact : contactsToUpdate) {
            contact.Title = 'Agriculture';
        }
        
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}