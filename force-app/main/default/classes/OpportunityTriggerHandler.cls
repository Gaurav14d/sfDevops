public class OpportunityTriggerHandler {
    public static void handleAfterUpdate(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        List<Opportunity> closedWonOpps = new List<Opportunity>();
        
        for (Opportunity opp : newList) {
            Opportunity oldOpp = oldMap.get(opp.Id);
            if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won' && opp.AccountId != null) {
                closedWonOpps.add(opp);
            }
        }
        
        if (!closedWonOpps.isEmpty()) {
            TaskService.createFollowUpTasks(closedWonOpps);
        }
    }
}