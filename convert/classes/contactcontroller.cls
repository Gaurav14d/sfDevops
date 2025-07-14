public with sharing class contactcontroller {
    @AuraEnabled(cacheable = true)
    public static List<Contact> getContactsByAccountId(Id accountId){
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
    }
}