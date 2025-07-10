public class stripeService {
    @AuraEnabled(cacheable=true)
    
    public static void createCharge(){
        StripeAPI__mdt stripeIntegration=[Select Secret_key__c,End_Point__c from StripeAPI__mdt];
        String result='fail';
        String stripeSecretKey = stripeIntegration.Secret_key__c;
        String endpoint = stripeIntegration.End_Point__c;
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + stripeSecretKey);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        String requestBody = 'amount=10000&currency=usd&source=tok_visa_debit';
        request.setBody(requestBody);
        
        Http http = new Http();
        HTTPResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            System.debug('Gaurav Dubey: ' + response.getBody());
            System.debug(response.getStatusCode());
        } else {
            System.debug('Error: ' + response.getBody());
            System.debug(response.getStatusCode());
        }
    }
    
    
    
}