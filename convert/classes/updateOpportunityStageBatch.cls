// Write a Batch Apex class to update the “OpportunityStage” field of all Opportunity records based on their “CloseDate”.
global  class updateOpportunityStageBatch implements Database.Batchable <sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT Id, CloseDate FROM Opportunity]);
    }
    global void execute(Database.BatchableContext bc, List<Opportunity> newOpportunty){
        for (Opportunity oppObj : newOpportunty){
            if(oppObj.CloseDate < Date.today()){
                oppObj.StageName = 'Closed Won';
            }else{
                oppObj.StageName = 'Prospecting';
            }
        }
        update newOpportunty;
    }
    global void finish(Database.BatchableContext bc){
        system.debug('Batch Finished Successfully');

    }

}