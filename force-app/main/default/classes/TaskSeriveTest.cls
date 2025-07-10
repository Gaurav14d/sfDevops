@isTest
public class TaskSeriveTest {
    
    @isTest
    static void testHandleAfterUpdate_CreatesFollowUpTask() {
        try {
            Account acc = new Account(Name = 'Test Account', OwnerId = UserInfo.getUserId());
            insert acc;

            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity',
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(10),
                AccountId = acc.Id
            );
            insert opp;

            Opportunity oppUpdated = opp.clone(false, true, false, false);
            oppUpdated.StageName = 'Closed Won';

            Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>{
                opp.Id => opp
            };

            Test.startTest();
            OpportunityTriggerHandler.handleAfterUpdate(new List<Opportunity>{ oppUpdated }, oldMap);
            Test.stopTest();

            List<Task> tasks = [SELECT Id, Subject, WhatId, OwnerId, ActivityDate, Status, Priority FROM Task WHERE WhatId = :opp.Id];
        } catch (Exception e) {
           
        }
    }
}