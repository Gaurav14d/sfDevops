@isTest
private class TestUpdateAccountFieldsFromOpportunity {
    
    @isTest
    static void testUpdateAccountFields() {
        
        // List<Account> testAccounts = new List<Account>();
        
        //    testAccounts.add(new Account(Name = 'Test Account ' + i));
        Account accObj =  new Account();
        accObj.Name = 'Test Account';
        
        insert accObj;
        
        List<Opportunity> testOpportunities = new List<Opportunity>();
        
        for (Integer i = 0; i < 10; i++) {
            testOpportunities.add(new Opportunity(
                Name = 'Test Opportunity Won ' + i,
                StageName = 'Prospecting',
                CloseDate = System.Today(),
                AccountId = accObj.Id
            ));
        }
        
        
        
        insert testOpportunities;
        List<Opportunity> newOpportunity = new List<Opportunity>();
        
        
        Integer count =  testOpportunities.size();
        for(opportunity opp:testOpportunities){
            if(count>10){
                opp.StageName = 'Closed Won';
                count--;
                newOpportunity.add(opp);
            }else{
                opp.StageName = 'Closed Lost';
                newOpportunity.add(opp);
            }
            
            
        }
        
        
        
        Test.startTest();
        
        update newOpportunity;
        Test.stopTest(); 
        
        
        
    }
}