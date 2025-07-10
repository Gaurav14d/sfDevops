public class ContactCreationHandler {
    public static void createContacts(List<Account> newAccounts) {
        List<Contact> conList = new List<Contact>();
        
        // Bulkify the logic
        for (Account acc : newAccounts) {
            if (acc.Name != null) {
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                conList.add(con);
            }
        }
        
        // Check if there are Contacts to insert
        if (!conList.isEmpty()) {
            try {
                insert conList;
            } catch (Exception e) {
                // Handle any errors during insertion
                System.debug('Error occurred while inserting Contacts: ' + e.getMessage());
                // You might want to add additional error handling or notifications here
            }
        }
    }
}