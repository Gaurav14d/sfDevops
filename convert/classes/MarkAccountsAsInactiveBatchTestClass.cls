@isTest
public class MarkAccountsAsInactiveBatchTestClass {
    @isTest
    static void testBatchExecution() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 200; i++) {
            Account acc = new Account(Name='Test Account ' + i, Active__c='Yes');
            testAccounts.add(acc);
        }
        insert testAccounts;
        
        List<Task> testTasks = new List<Task>();
        for(Account acc : testAccounts) {
            Task t = new Task(Subject='Test Task', WhatId=acc.Id, Status='Not Started');
            testTasks.add(t);
        }
        insert testTasks;
        
        // Start the batch
        Test.startTest();
        Database.executeBatch(new MarkAccountsAsInactiveBatch());
        Test.stopTest();
        
        // Verify accounts are marked as inactive and tasks are created
        List<Account> updatedAccounts = [SELECT Id, Active__c FROM Account WHERE Id IN :testAccounts];
        System.assertEquals(200, updatedAccounts.size());
        for(Account acc : updatedAccounts) {
            System.assertEquals('No', acc.Active__c);
        }
        
        List<Task> createdTasks = [SELECT Id, WhatId FROM Task WHERE WhatId IN :testAccounts];
        System.assertEquals(200, createdTasks.size());
        
        // Verify logger records are created
        List<Logger__c> loggers = [SELECT Id, Account__c, Status__c FROM Logger__c WHERE Account__c IN :testAccounts];
        System.assertEquals(200, loggers.size());
    }
}