public with sharing class AccountController { 

    @AuraEnabled( cacheable = true ) 

    public static List< Account > getAccounts() { 

        return [ SELECT Id, Name, Industry FROM Account LIMIT 10 ]; 

    } 

    @AuraEnabled( cacheable = true )

    public static void saveAccounts(List<Account> accList){

        Insert accList;

        /*if(accList.size()>0 && accList != null){

            insert accList;

        }*/

    } 

}