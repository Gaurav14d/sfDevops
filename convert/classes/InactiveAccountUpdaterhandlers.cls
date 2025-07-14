/*@Name -  Gaurav Dubey
@Author - Gaurav Dubey
@Description - We need to mark all account as inactive which does not have taks, event and case.
@Date - 29/05/2024
@IsWorking  -  
*/

global with sharing class InactiveAccountUpdaterhandlers implements Database.Batchable<SObject> {
    global Integer countForInactive = 0;
    global Integer countForProcessedRecord = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, OwnerId FROM Account WHERE Active__c != 'No']);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Task> tasksToCreate = new List<Task>();
        
        for (Account acc : scope) {
            // Check if the account has pending tasks, events, or cases
            if (!hasPendingTasksEventsOrCases(acc)) {
                // Mark account as inactive
                acc.Active__c = 'false';
                countForInactive++;
                
                // Create task for account owner to review tasks
                Task newTask = new Task(
                    WhatId = acc.Id,
                    Subject = 'Review Tasks',
                    Description = 'Please review tasks for this account.',
                    ActivityDate = Date.today(),
                    OwnerId = acc.OwnerId
                );
                tasksToCreate.add(newTask);
            }
            
            countForProcessedRecord++;
        }
        
        // Update accounts
        update scope;
        
        // Insert tasks
        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }
    
    private Boolean hasPendingTasksEventsOrCases(Account acc) {
        // Check if the account has pending tasks, events, or cases
        // Implement your logic here based on your requirements
        // For demonstration, let's assume this method always returns false
        return false;
    }
    
    global void finish(Database.BatchableContext bc) {
        // Optionally, perform any post-processing logic here
    }
}