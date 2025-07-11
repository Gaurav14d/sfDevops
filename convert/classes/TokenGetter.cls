public class TokenGetter {
    private static final String BASE_URL = 'https://crmapipreprod.centrumwealth.co.in';
    private static final String USERNAME = 'SFTeam';
    private static final String PASSWORD = 'SFTeam@123';
    
    public static String generateToken() {
        String token = '';
        String authEndpoint = BASE_URL + '/api/Milesauthenticate/authenticateuser'; 
        String requestBody = 'grant_type=password&username=' + EncodingUtil.urlEncode(USERNAME, 'UTF-8') + '&password=' + PASSWORD; //EncodingUtil.urlEncode(PASSWORD, 'UTF-8');
        
        System.debug('Request Body: ' + requestBody);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(authEndpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization', createBasicAuthHeader(USERNAME, PASSWORD));
        request.setBody(requestBody);
        
        HttpResponse response = http.send(request);
        
        System.debug('Response Status: ' + response.getStatus());
        System.debug('Response Body: ' + response.getBody());
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            token = (String) jsonResponse.get('TokenId');
            System.debug('Access Token: ' + token);
        } else if (response.getStatusCode() == 401) {
            System.debug('Authentication failed: ' + response.getBody());
        } else {
            System.debug('Error: ' + response.getBody());
        }
        return token;
    }
    
    private static String createBasicAuthHeader(String username, String password) {
        String auth = username + ':' + password;
        Blob authBlob = Blob.valueOf(auth);
        return 'Basic ' + EncodingUtil.base64Encode(authBlob);
    }
}