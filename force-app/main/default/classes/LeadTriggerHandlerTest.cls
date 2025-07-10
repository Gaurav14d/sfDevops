@isTest
private class LeadTriggerHandlerTest {

    @isTest
    static void testHandleLeadActivity() {
        // Create test data
        List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 5; i++) {
            Lead testLead = new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'TestCompany' + i,
                OwnerId = UserInfo.getUserId()
            );
            testLeads.add(testLead);
        }
        
        // Call the handler method
        Test.startTest();
        LeadTriggerHandler.handleLeadActivity(testLeads);
        Test.stopTest();
        
        // Verify that tasks were created for each lead
        List<Task> createdTasks = [SELECT Id, Priority FROM Task WHERE WhoId IN :testLeads];
        System.assertEquals(testLeads.size(), createdTasks.size(), 'Incorrect number of tasks created');
        
        // Verify task fields
        for(Task t : createdTasks) {
            System.assertEquals('High', t.Priority, 'Incorrect task priority');
            System.assertEquals('Split the revenue amongst the team with high priority', t.Description, 'Incorrect task description');
            System.assertEquals('Not Started', t.Status, 'Incorrect task status');
            System.assertEquals('Split Revenue Amongst Team', t.Subject, 'Incorrect task subject');
        }
    }
}