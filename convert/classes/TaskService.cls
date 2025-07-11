public class TaskService {
    public static void createFollowUpTasks(List<Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : opportunities) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Account> accountMap = new Map<Id, Account>(
            [SELECT Id, OwnerId FROM Account WHERE Id IN :accountIds]
        );

        List<Task> taskList = new List<Task>();
        for (Opportunity opp : opportunities) {
            Account acc = accountMap.get(opp.AccountId);
            if (acc != null) {
                taskList.add(new Task(
                    Subject = 'Follow up with customer',
                    WhatId = opp.Id,
                    OwnerId = acc.OwnerId,
                    ActivityDate = Date.today().addDays(3),
                    Status = 'Not Started',
                    Priority = 'Normal'
                ));
            }
        }

        if (!taskList.isEmpty()) {
            insert taskList;
        }
    }
}