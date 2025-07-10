public with sharing class accountHelper {
    public static void updateAccountFields(List<Account> newAccount){
        for(Account accObj : newAccount){
            if(accObj.Active__c == 'Yes'){
            accObj.Name = 'Gaurav Dubey';  
            }
        }
    }
}