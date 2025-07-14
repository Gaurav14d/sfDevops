global class batchApex1 implements Database.batchable<sObject> {
    global Database.queryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, FirstName FROM Contact LIMIT 22');
    }
    global void execute(Database.BatchableContext bc, List<Contact> listofContacts){
        for(Contact conObj : listofContacts){
            conObj.FirstName = 'updateBatch - '+ conObj.FirstName;
        }
        update listofContacts;
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Finished Successfully');
    }
}