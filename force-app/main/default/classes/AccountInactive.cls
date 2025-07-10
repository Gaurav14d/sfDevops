/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-10-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountInactive {
    public static void getNewRecord() {
        List<Account> accountsToUpdate = new List<Account>();
        List<Task> tasksToCreate = new List<Task>();
        List<Logger__c> loggers = new List<Logger__c>();
        // for Testing purposes
        // List<Account> accounts = [SELECT Id, Name, Active__c FROM Account];
        // Query to get all active accounts
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Active__c = 'Yes'];
        Set<Id> accountIds = new Set<Id>();
        for (Account accountRecord : accounts) {
            accountIds.add(accountRecord.Id);
        }
        Set<Id> accountsWithPendingTasks = new Set<Id>();
        Set<Id> accountsWithPendingEvents = new Set<Id>();
        Set<Id> accountsWithPendingCases = new Set<Id>();
        
        // Query to get related tasks, events, and cases
        
        List<Task> taskRecords = [SELECT AccountId FROM Task WHERE Status != 'Completed' AND AccountId IN :accountIds];
        for (Task tasks : taskRecords) {
            accountsWithPendingTasks.add(tasks.AccountId);
        }
        
        List<Event> eventRecords = [SELECT AccountId FROM Event WHERE EndDateTime > :DateTime.now() AND AccountId IN :accountIds];
        for (Event eventss : eventRecords) {
            accountsWithPendingEvents.add(eventss.AccountId);
        }
        
        List<Case> caseRecords = [SELECT AccountId FROM Case WHERE Status != 'Closed' AND AccountId IN :accountIds];
        for (Case cases : caseRecords) {
            accountsWithPendingCases.add(cases.AccountId);
        }
        
        // Process accounts without pending tasks, events, or cases
        Integer totalProcessed = 0;
        Integer markedInactive = 0;
        Integer notMarkedInactive = 0;
        
        for (Account accountRecord : accounts) {
            totalProcessed++;
            if (!accountsWithPendingTasks.contains(accountRecord.Id) && 
                !accountsWithPendingEvents.contains(accountRecord.Id) && 
                !accountsWithPendingCases.contains(accountRecord.Id)) {
                    accountRecord.Active__c = 'No';
                    accountsToUpdate.add(accountRecord);
                    markedInactive++;
                    
                    
                    // Created a task for the account owner
                    Task task = new Task();
                    task.Subject = 'Review Account Inactive Status';
                    task.OwnerId = accountRecord.OwnerId;
                    task.WhatId = accountRecord.Id;
                    task.Status = 'Not Started';
                    task.Priority = 'High';
                    tasksToCreate.add(task);
                    // Log the processing status
                    Logger__c logger = new Logger__c();
                    logger.Account__c = accountRecord.Id;
                    logger.Status__c = 'Inactive';
                    logger.Reason__c = '';
                    loggers.add(logger); 
                } else {
                    notMarkedInactive++;
                    
                    // Log the processing status
                    Logger__c logger = new Logger__c();
                    logger.Account__c = accountRecord.Id;
                    logger.Status__c = 'Active';
                    String reason = '';
                    if (accountsWithPendingTasks.contains(accountRecord.Id)) {
                        reason += 'Pending Tasks; ';
                    }
                    if (accountsWithPendingEvents.contains(accountRecord.Id)) {
                        reason += 'Pending Events; ';
                    }
                    if (accountsWithPendingCases.contains(accountRecord.Id)) {
                        reason += 'Pending Cases; ';
                    }
                    logger.Reason__c = reason.trim();
                    loggers.add(logger);
                } 
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
            insert tasksToCreate;
            if(!accountsToUpdate.isEmpty()){
                update accountsToUpdate;
                insert tasksToCreate;
            }
        }
        insert loggers;
        //emailNotification(accountsToUpdate);
        
        sendSummaryEmail(accounts.size(), accountsToUpdate.size(), accounts.size() - accountsToUpdate.size());
    }
    
    public static void emailNotification(List<Account> accountRecordList){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =:'Inactive_Account_Template'];
        for(Account acc : accountRecordList){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTargetObjectId(acc.OwnerId);
            email.setTemplateId('Inactive_Account_Template');
            email.setWhatId(acc.Id);
            email.setSaveAsActivity(false);
            emails.add(email);
        }
        Messaging.sendEmail(emails);
    }
    public static void sendSummaryEmail(Integer totalProcessed, Integer markedInactive, Integer notMarkedInactive) {
        String adminEmail = 'gauravdubey5358@gmail.com'; 
        String subject = 'Account Summary';
        String body = 'Total Records Processed: ' + totalProcessed + '\n' +
            'Marked as Inactive: ' + markedInactive + '\n' +
            'Not Marked as Inactive: ' + notMarkedInactive;
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { adminEmail });
        email.setSubject(subject);
        email.setPlainTextBody(body);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}