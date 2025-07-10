public class SipStpDataController {
    
    private static final String ENDPOINT_URL = 'https://crmapipreprod.centrumwealth.co.in/api/SipStpData';
    
    public static void getData() {
        String bearerToken = TokenGetter.generateToken();
        
        if (String.isNotBlank(bearerToken)) {
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT_URL);
            request.setMethod('GET');
            request.setHeader('Authorization', 'Bearer ' + bearerToken);
            
            Http http = new Http();
            
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                System.debug('Response: ' + jsonResponse);
            } else {
                System.debug('Error occurred: Http status code ' + response.getStatusCode());
            }
        } else {
            System.debug('Failed to obtain bearer token');
        }
    }
}