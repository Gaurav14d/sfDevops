public class UpdateAccountFieldsFromOpportunity {
    public static void updateAccountFields(List<Opportunity> oppsToUpdate) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : oppsToUpdate) {
            if (opp.StageName == 'Closed Won') {
                accountIds.add(opp.AccountId);
            } else if (opp.StageName == 'Closed Lost') {
                accountIds.add(opp.AccountId);
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accountId : accountIds) {
            Integer closedWonCount = 0;
            Integer closedLostCount = 0;
            
            for (Opportunity opp : [SELECT Id, StageName FROM Opportunity WHERE AccountId = :accountId AND StageName IN ('Closed Won', 'Closed Lost')]) {
                if (opp.StageName == 'Closed Won') {
                    closedWonCount++;
                } else if (opp.StageName == 'Closed Lost') {
                    closedLostCount++;
                }
            }
            
            System.debug('Account Id: ' + accountId);
            System.debug('Closed Won Count: ' + closedWonCount);
            System.debug('Closed Lost Count: ' + closedLostCount);
            
        }
        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}