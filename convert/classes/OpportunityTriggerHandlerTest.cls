@isTest
public class OpportunityTriggerHandlerTest {
    
    @isTest
    static void testHandleAfterUpdate() {
        // Step 1: Create test Account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Step 2: Create test Opportunity (not Closed Won initially)
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10),
            AccountId = acc.Id
        );
        insert opp;

        // Step 3: Update Opportunity to 'Closed Won'
        opp.StageName = 'Closed Won';

        // Simulate Trigger.oldMap
        Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>{
            opp.Id => [SELECT Id, StageName, AccountId FROM Opportunity WHERE Id = :opp.Id]
        };

        // Step 4: Call the handler
        Test.startTest();
        OpportunityTriggerHandler.handleAfterUpdate(new List<Opportunity>{opp}, oldMap);
        Test.stopTest();

        // Step 5: Verify Task was created
        List<Task> tasks = [SELECT Id, WhatId, Subject FROM Task WHERE WhatId = :opp.Id];
        System.assertEquals(1, tasks.size(), 'A follow-up task should be created');
        System.assertEquals('Follow up with customer', tasks[0].Subject, 'The task subject should match expected');
    }
}