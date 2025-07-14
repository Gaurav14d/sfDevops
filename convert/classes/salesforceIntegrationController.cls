public class salesforceIntegrationController {
    
    @future(callout=true)
    public static void getDetails(){
        HttpRequest req = new HttpRequest();
        req.setEndPoint('callout:Salesforce/services/apexrest/Account/');
        req.setHeader('content-type', 'application-json; charset=UTF-8');
        req.setHeader('Accept', 'application-json');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(req);
        
        system.debug('response code:' + response.getStatusCode());
        system.debug('response body:'+ response.getBody());
    }
    @future(callout=true)
    public static void getAccountDetails(){
        HttpRequest req = new HttpRequest();
        req.setEndPoint('callout:Salesforce/services/apexrest/contact/');
        req.setHeader('content-type', 'application-json; charset=UTF-8');
        req.setHeader('Accept', 'application-json');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse response = http.send(req);
        
        system.debug('response code:' +response.getStatusCode());
        system.debug('response body:'+response.getBody());
    }
}