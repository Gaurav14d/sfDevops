@isTest
private class AccountInactiveTest {
    
    @isTest
    static void testGetNewRecord() {
        // Create test data
        List<Account> testAccounts = new List<Account>();
        List<Task> testTasks = new List<Task>();
        List<Event> testEvents = new List<Event>();
        List<Case> testCases = new List<Case>();
        
        // Create accounts
        Account acc1 = new Account(Name = 'Test Account 1', Active__c = 'Yes');
        Account acc2 = new Account(Name = 'Test Account 2', Active__c = 'Yes');
        testAccounts.add(acc1);
        testAccounts.add(acc2);
        insert testAccounts;
        
        // Create related tasks, events, and cases
        Task task1 = new Task(Subject = 'Test Task 1', Status = 'Not Started', WhatId = acc1.Id);
        Task task2 = new Task(Subject = 'Test Task 2', Status = 'Completed', WhatId = acc2.Id);
        testTasks.add(task1);
        testTasks.add(task2);
        insert testTasks;
        
        Event event1 = new Event(Subject = 'Test Event 1', StartDateTime = DateTime.now(), EndDateTime = DateTime.now().addDays(1), WhatId = acc1.Id);
        Event event2 = new Event(Subject = 'Test Event 2', StartDateTime = DateTime.now(), EndDateTime = DateTime.now().addDays(1), WhatId = acc2.Id);
        testEvents.add(event1);
        testEvents.add(event2);
        insert testEvents;
        
        Case case1 = new Case(Status = 'New', AccountId = acc1.Id);
        Case case2 = new Case(Status = 'Closed', AccountId = acc2.Id);
        testCases.add(case1);
        testCases.add(case2);
        insert testCases;
        
        Test.startTest();
        // Call the method under test
        AccountInactive.getNewRecord();
        Test.stopTest();
        
        // Verify account updates
        acc1 = [SELECT Id, Active__c FROM Account WHERE Id = :acc1.Id];
        acc2 = [SELECT Id, Active__c FROM Account WHERE Id = :acc2.Id];
        
        System.assertEquals('No', acc1.Active__c, 'Account should be marked as inactive');
        System.assertEquals('Yes', acc2.Active__c, 'Account should remain active');
        
        // Verify tasks creation for inactive account
        List<Task> tasks = [SELECT Id, Subject, Status, WhatId FROM Task WHERE WhatId = :acc1.Id];
        System.assertEquals(1, tasks.size(), 'One task should be created for inactive account');
        
        // Add more assertions as needed for logging, email notifications, etc.
    }
    
    @isTest
    static void testEmailNotification() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account', Active__c = 'Yes');
        insert testAccount;
        
        Test.startTest();
        // Call the emailNotification method
        AccountInactive.emailNotification(new List<Account>{ testAccount });
        Test.stopTest();
        
        // Verify email sending behavior
        // Add assertions based on behavior in production
    }
    
    @isTest
    static void testSendSummaryEmail() {
        Test.startTest();
        // Call the sendSummaryEmail method
        AccountInactive.sendSummaryEmail(10, 5, 5);
        Test.stopTest();
        
        // Verify summary email creation and sending
        // Add assertions based on behavior in production
    }
}