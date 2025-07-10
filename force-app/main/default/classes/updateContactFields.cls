public class updateContactFields implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Active__c	='No']);
    }
    public void execute(Database.BatchableContext bc,List<Account> listOfAccount){
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Account accObj: listOfAccount){
            List<Contact> relatedContacts = [SELECT Id, Name, Description FROM Contact WHERE AccountId =:accObj.Id];
            for(Contact conObj : relatedContacts){
                conObj.Description = 'Belong to Inactive Account';
                contactsToUpdate.add(conObj);
            }
        }
        
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch Processing Finished');
    }
}