public class OpportunityHelper{
public static void updateAccountFields(List<Opportunity> listOfOpportunity, Map<Id, Opportunity> oldMapOpp){
Set<Id> accIdSet = new Set<Id>();

for(Opportunity oppObj : listOfOpportunity){
    accIdSet.add(oppObj.AccountId);       
}

try{
    List<Account> accList = new List<Account>();
    for(Account acc : [Select Id, (Select Id From Opportunities where StageName = 'Closed Lost') from Account where Id IN : accIdSet]){
        acc.Closed_Lost__c = acc.Opportunities.size();
        System.debug('Closed Lost inside loop');
        accList.add(acc);
    }
    if(!accList.isEmpty()) {
        update accList;
    }
} catch(Exception e) {
    
    System.debug('Exception occurred while updating Closed_Lost__c: ' + e.getMessage());
}

try { 
    List<Account> accList1 = new List<Account>();
    for(Account accObj : [Select Id, (Select Id From Opportunities where StageName = 'Closed Won') from Account where Id IN : accIdSet]){
        accObj.Closed_Won__c = accObj.Opportunities.size();
        System.debug('Closed Won inside loop');
        accList1.add(accObj);
    }   
    if(!accList1.isEmpty()) {
        update accList1;
    }
} catch(Exception e) {
    
    System.debug('Exception occurred while updating Closed_Won__c: ' + e.getMessage());
}
}


}