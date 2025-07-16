public class createAccounts{
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Active__c, LastModifiedDate, Type FROM Account ORDER BY Name];
    }
}