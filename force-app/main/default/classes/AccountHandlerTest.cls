@isTest
private class AccountHandlerTest {
 
    @isTest
    static void testUpdateRelatedOpportunitiesCompleted() {
        
        Account testAccount = new Account(
            Name = 'Test Account',
            Onboarding_Status__c = 'Completed',
            Cut_of_Point_Date__c = Date.today().addDays(30)
        );
        insert testAccount;
        
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(15), 
            AccountId = testAccount.Id
        );
        insert testOpportunity;
        
        
        Test.startTest();
        AccountHandler.updateRelatedOpportunities(new List<Account>{ testAccount });
        Test.stopTest();
        
        Opportunity updatedOpportunity = [SELECT Id, CloseDate FROM Opportunity WHERE Id = :testOpportunity.Id];
        System.assertEquals(testAccount.Cut_of_Point_Date__c, updatedOpportunity.CloseDate,
                            'Expected CloseDate to be updated to Account Cut_of_Point_Date__c');
    }
    
    @isTest
    static void testUpdateRelatedOpportunitiesNotCompleted() {
        
        Account testAccount = new Account(
            Name = 'Test Account',
            Onboarding_Status__c = 'Not Completed'
        );
        insert testAccount;
        
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting', 
            CloseDate = Date.today().addDays(15), 
            AccountId = testAccount.Id
        );
        insert testOpportunity;
        
        Test.startTest();
        AccountHandler.updateRelatedOpportunities(new List<Account>{ testAccount });
        Test.stopTest();
        
        Opportunity updatedOpportunity = [SELECT Id, CloseDate FROM Opportunity WHERE Id = :testOpportunity.Id];
        System.assertNotEquals(testAccount.Cut_of_Point_Date__c, updatedOpportunity.CloseDate,
                               'CloseDate should not be updated as Onboarding_Status__c is not Completed');
    }
}