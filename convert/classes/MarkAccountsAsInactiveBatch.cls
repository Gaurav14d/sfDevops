/*@Name -  Gaurav Dubey
@Author - Gaurav Dubey
@Description - We need to mark all account as inactive which does not have tasks, event and case.
@Date - 04/07/2024
@IsWorking  -  Yes
*/
global with sharing class MarkAccountsAsInactiveBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    global Integer totalProcessed = 0;
    global Integer markedInactive = 0;
    global Integer notMarkedInactive = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Query to retrieve accounts with 'Yes' or 'No' in Active__c field
        return Database.getQueryLocator([SELECT Id, Name, Active__c, OwnerId, Owner.Email FROM Account WHERE Active__c IN ('Yes', 'No')]);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> listOfAccount) {
        // Lists to store records and messages for processing
        List<Logger__c> loggerstoStore = new List<Logger__c>();
        List<Account> accountsToUpdate = new List<Account>();
        List<Task> tasksToCreate = new List<Task>();
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>(); // use camel case.
        
        // Sets to store IDs for efficient lookup
        Set<Id> accountIds = new Set<Id>();
        Set<Id> accountTask = new Set<Id>();
        Set<Id> accountCase = new Set<Id>();
        Set<Id> accountEvent = new Set<Id>();
        
        // Populate accountIds set for all accounts in the batch
        for (Account accObj : listOfAccount) {
            accountIds.add(accObj.Id);
        }
        
        // Populate sets with IDs of related tasks, cases, and events
        for (Task tasks : [SELECT AccountId FROM Task WHERE Status != 'Completed' AND AccountId IN :accountIds]) { // Create a list and loop over that list.
            accountTask.add(tasks.AccountId);
        }
        
        for (Case cases : [SELECT AccountId FROM Case WHERE Status != 'Closed' AND AccountId IN :accountIds]) {
            accountCase.add(cases.AccountId);
        }
        for (Event events : [SELECT WhatId FROM Event WHERE EndDateTime > : DateTime.now() AND WhatId IN :accountIds]) {
            accountEvent.add(events.WhatId);
        }
        // Process each account in the batch
        for (Account accObj : listOfAccount) {
            totalProcessed++;
            
            // Check if the account is not associated with any open tasks, cases, or future events
            if (!accountTask.contains(accObj.Id) && !accountCase.contains(accObj.Id) && !accountEvent.contains(accObj.Id)) {
                markedInactive++;
                accObj.Active__c = 'No';
                accountsToUpdate.add(accObj);
                
                // Create a task for the account owner to review the account
                Task reviewTask = new Task();
                reviewTask.Subject = 'Review Account: ' + accObj.Name;
                reviewTask.OwnerId = accObj.OwnerId;
                reviewTask.WhatId = accObj.Id;
                reviewTask.Status = 'Not Started';
                tasksToCreate.add(reviewTask);
                
                // Create a logger record for tracking
                Logger__c logger = new Logger__c();  
                logger.Account__c = accObj.Id;
                logger.Status__c = 'Inactive';
                loggerstoStore.add(logger);
                
                
            } else {
                notMarkedInactive++; 
                Logger__c logger = new Logger__c();
                logger.Account__c = accObj.Id;
                logger.Status__c = 'Active';
                loggerstoStore.add(logger);
                
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
        insert loggerstoStore;
        
        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }
    
    
    global void finish(Database.BatchableContext bc) {
        
        
        String adminEmail = 'gaurav14dubey123@gmail.com';
        String subject = 'Account Processing Summary';
        String body = 'Total Records Processed: ' + totalProcessed + '\n' +
            'Marked as Inactive: ' + markedInactive + '\n' +
            'Not Marked as Inactive: ' + notMarkedInactive;
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { adminEmail });
        email.setSubject(subject);
        email.setPlainTextBody(body);
        system.Debug('Batch Process Finished');
    }
}