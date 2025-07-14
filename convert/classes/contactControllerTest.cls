@isTest
private class contactControllerTest {
    
    @isTest
    static void testGetContacts() {
        // Create test data
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Phone = '123-456-789' + i
            ));
        }
        insert testContacts;
        
        Test.startTest();
        // Call the method to test
        List<Contact> resultContacts = contactController.getContacts();
        Test.stopTest();
        
        // Assert the results
        System.assertEquals(5, resultContacts.size(), 'Expected 5 contacts');
        // Additional assertions can be added to verify specific field values
    }
    
    @isTest
    static void testSaveContacts() {
        // Create test data
        List<Contact> testContacts = new List<Contact>();
        for(Integer i = 0; i < 3; i++) {
            testContacts.add(new Contact(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Phone = '123-456-789' + i
            ));
        }
        
        Test.startTest();
        // Call the method to test
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        contactController.saveContacts(testContacts);
        Test.stopTest();
        
        // Assert that contacts were inserted successfully
        List<Contact> insertedContacts = [SELECT Id, FirstName, LastName, Phone FROM Contact];
        System.assertEquals(3, insertedContacts.size(), 'Expected 3 contacts to be inserted');
        // Additional assertions can be added to verify specific field values
    }
    
    // Mock HttpResponse class to handle the mock callout
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            return res;
        }
    }
}