@IsTest
public class TestUpdateContactFields {
    
    // Test method to insert test data and run the batch job
    @IsTest
    static void testBatchUpdateContacts() {
        // Insert test accounts with Active__c = 'No'
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name='Test Account ' + i, Active__c='No'));
        }
        insert testAccounts;
        
        // Insert test contacts related to the test accounts
        List<Contact> testContacts = new List<Contact>();
        for (Account acc : testAccounts) {
            testContacts.add(new Contact(AccountId=acc.Id, FirstName='Test', LastName='Contact'));
        }
        insert testContacts;
        
        Test.startTest();
        // Start the batch job
        updateContactFields batchJob = new updateContactFields();
        Database.executeBatch(batchJob);
        
        Test.stopTest();
        
        // Verify that contacts related to inactive accounts were updated
        List<Contact> updatedContacts = [SELECT Id, Description FROM Contact WHERE AccountId IN :testAccounts];
        System.assertEquals(testContacts.size(), updatedContacts.size(), 'Number of updated contacts should match the inserted contacts');
        for (Contact con : updatedContacts) {
            System.assertEquals('Belong to Inactive Account', con.Description, 'Contact description should be updated');
        }
    }
}