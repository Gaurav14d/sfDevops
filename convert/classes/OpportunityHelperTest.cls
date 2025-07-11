@isTest
public class OpportunityHelperTest {
    
    @isTest
    static void testUpdateAccountFields() {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            accList.add(new Account(Name = 'Test Account ' + i));
        }
        insert accList; 
        List<Opportunity> lostOpps = new List<Opportunity>();
        for(Account acc : accList) {
            lostOpps.add(new Opportunity(
                Name = 'Closed Lost Opp',
                StageName = 'Closed Lost',
                AccountId = acc.Id,
                CloseDate = Date.today() 
            ));
        }
        insert lostOpps; 
        List<Opportunity> wonOpps = new List<Opportunity>();
        for(Account acc : accList) {
            wonOpps.add(new Opportunity(
                Name = 'Closed Won Opp',
                StageName = 'Closed Won',
                AccountId = acc.Id,
                CloseDate = Date.today()  
            ));
        }
        insert wonOpps;
        
        Test.startTest();
        OpportunityHelper.updateAccountFields(lostOpps, new Map<Id, Opportunity>());
        OpportunityHelper.updateAccountFields(wonOpps, new Map<Id, Opportunity>());
        Test.stopTest();
        
        accList = [SELECT Id, Closed_Lost__c, Closed_Won__c FROM Account WHERE Id IN :accList];
        
        
        for(Account acc : accList) {
            System.assertEquals(1, acc.Closed_Lost__c, 'Closed Lost count incorrect');
        }
        for(Account acc : accList) {
            System.assertEquals(1, acc.Closed_Won__c, 'Closed Won count incorrect');
            
        }
    }
}