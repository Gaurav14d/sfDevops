@isTest
private class OpportunityHelperTes {
    
    @isTest
    static void testUpdateAccountFields() {
        // Create test data: Accounts and related Opportunities
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{ acc1, acc2 };
            
            Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Closed Lost', AccountId = acc1.Id);
        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity 2', StageName = 'Closed Won', AccountId = acc2.Id);
        Opportunity opp3 = new Opportunity(Name = 'Test Opportunity 3', StageName = 'Closed Lost', AccountId = acc1.Id);
        insert new List<Opportunity>{ opp1, opp2, opp3 };
            
            // Prepare oldMapOpp for trigger handler method
            Map<Id, Opportunity> oldMapOpp = new Map<Id, Opportunity>{
                opp1.Id => new Opportunity(Id = opp1.Id, StageName = 'Prospecting'),
                    opp2.Id => new Opportunity(Id = opp2.Id, StageName = 'Closed Won'),
                    opp3.Id => new Opportunity(Id = opp3.Id, StageName = 'Closed Lost')
                    };
                        
                        List<Opportunity> listOfOpportunity = [SELECT Id, StageName, AccountId FROM Opportunity WHERE Id IN :oldMapOpp.keySet()];
        
        Test.startTest();
        // Call the helper method
        OpportunityHelper.updateAccountFields(listOfOpportunity, oldMapOpp);
        Test.stopTest();
        
        // Verify the results
        Account updatedAcc1 = [SELECT Id, Closed_Lost__c FROM Account WHERE Id = :acc1.Id];
        Account updatedAcc2 = [SELECT Id, Closed_Won__c FROM Account WHERE Id = :acc2.Id];
        
        // Verify Closed_Lost__c update for acc1
        System.assertEquals(2, updatedAcc1.Closed_Lost__c, 'Expected Closed_Lost__c to be 2 for acc1');
        
        // Verify Closed_Won__c update for acc2
        System.assertEquals(1, updatedAcc2.Closed_Won__c, 'Expected Closed_Won__c to be 1 for acc2');
    }
    
    // Additional test methods can be added to cover more scenarios if needed
}