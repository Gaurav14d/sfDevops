public with sharing class Accountcontrollercontact {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Industry, Phone, Website FROM Account];

    }
}