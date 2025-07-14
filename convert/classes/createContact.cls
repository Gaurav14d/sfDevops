public with sharing class createContact {
    
    public static void createContacts(List<Account> accList) {
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList) {
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            conList.add(con);
        }
        if(!conList.isEmpty()) {
            insert conList;
        }
    }
}