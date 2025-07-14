/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-14-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class createAccounts{
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Active__c, LastModifiedDate, Type FROM Account ORDER BY Name];
    }
}