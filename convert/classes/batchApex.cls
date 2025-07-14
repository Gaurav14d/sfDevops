global class batchApex implements Database.Batchable<sObject> {
    
    global Database.queryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    global void execute(Database.BatchableContext bc, List<Account> listofAccounts){
        for(Account accObj : listofAccounts){
            accObj.Name = 'AccUpdateByBatch - '+ accObj.Name;
        }
        update listofAccounts;
    }
    global void finish(Database.BatchableContext bc){
        System.debug('batch finished successfully');
        Database.executeBatch(new batchApex1(),22);
        System.debug('Batch Finished Successfully');
    }
    
}