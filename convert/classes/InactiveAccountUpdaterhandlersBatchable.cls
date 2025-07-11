public with sharing class InactiveAccountUpdaterhandlersBatchable implements Database.Batchable<sObject> {

    // Start method to collect records to process
    public Database.QueryLocator start(Database.BatchableContext context) {
        // Query to get all active accounts
        return Database.getQueryLocator([
            SELECT Id, OwnerId
            FROM Account
            WHERE Active__c = 'Yes'
        ]);
    }

    // Execute method to process records
    public void execute(Database.BatchableContext context, List<Account> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        List<Task> tasksToCreate = new List<Task>();

        Set<Id> accountIds = new Set<Id>();
        for (Account accountRecord : scope) {
            accountIds.add(accountRecord.Id);
        }

        Set<Id> accountsWithPendingTasks = new Set<Id>();
        Set<Id> accountsWithPendingEvents = new Set<Id>();
        Set<Id> accountsWithPendingCases = new Set<Id>();

        // Query to get related tasks, events, and cases
        for (Task task : [SELECT AccountId FROM Task WHERE Status != 'Completed' AND AccountId IN :accountIds]) {
            accountsWithPendingTasks.add(task.AccountId);
        }
        for (Event event : [SELECT AccountId FROM Event WHERE EndDateTime > :DateTime.now() AND AccountId IN :accountIds]) {
            accountsWithPendingEvents.add(event.AccountId);
        }
        for (Case caseRecord : [SELECT AccountId FROM Case WHERE Status != 'Closed' AND AccountId IN :accountIds]) {
            accountsWithPendingCases.add(caseRecord.AccountId);
        }

        // Process accounts without pending tasks, events, or cases
        for (Account accountRecord : scope) {
            if (!accountsWithPendingTasks.contains(accountRecord.Id) &&
                !accountsWithPendingEvents.contains(accountRecord.Id) &&
                !accountsWithPendingCases.contains(accountRecord.Id)) {
                accountRecord.Active__c = 'No';
                accountsToUpdate.add(accountRecord);

                // Create a task for the account owner
                Task task = new Task();
                task.Subject = 'Review Account Inactive Status';
                task.OwnerId = accountRecord.OwnerId;
                task.WhatId = accountRecord.Id;
                task.Status = 'Not Started';
                task.Priority = 'High';
                tasksToCreate.add(task);
            }
        }

        // Update accounts and create tasks
        update accountsToUpdate;
        insert tasksToCreate;
    }

    // Finish method to perform final tasks
    public void finish(Database.BatchableContext context) {
        // Perform any final tasks here
    }
}