@isTest
private class stripeServiceTest {
    
    private class MockHttpResponse implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"id":"ch_123456789","amount":10000,"currency":"usd","status":"succeeded"}');
            res.setStatusCode(200);
            return res;
        }
    }
    
    @isTest
    static void testCreateCharge() {
        // Set up mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        
        Test.startTest();
        // Call the method that makes the HTTP callout
        stripeService.createCharge();
        Test.stopTest();
        
        // Verify the number of callouts made
        Integer actualCallouts = Limits.getCallouts();
        System.assertEquals(1, actualCallouts, 'Expected only one callout. Actual: ' + actualCallouts);
    }
}