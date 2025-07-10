@RestResource(urlMapping='/Account/*')
global class salesforceAccessForIntegration {
    
    @HttpGet
    global static List<Account>getAccounts(){
        return [SELECT Id, Name FROM Account];
    }
    
}