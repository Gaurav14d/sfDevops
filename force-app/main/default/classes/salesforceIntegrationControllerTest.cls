@isTest
public class salesforceIntegrationControllerTest {
    
    @isTest
    static void testGetDetails() {
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        
        salesforceIntegrationController.getDetails();
        
        
        Test.stopTest();
    }
    
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            res.setBody('{"success": true}');
            return res;
        }
    }
}