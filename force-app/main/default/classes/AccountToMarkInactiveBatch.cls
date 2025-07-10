global with sharing class AccountToMarkInactiveBatch implements Database.Batchable<SObject> {
    global Integer countForInactive = 0;
    global Integer countForProcessedRecord = 0;

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Active__c != 'No']);
    }

    global void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Logger__c> loggersToInsert = new List<Logger__c>();

        for (Account acc : scope) {
            // Process account and determine if it should be marked as inactive
            Boolean shouldBeInactive = determineIfInactive(acc);

            // Create logger record
            Logger__c logger = new Logger__c(
                Account__c = acc.Id,
                Status__c = shouldBeInactive ? 'Inactive' : 'Not Inactive',
                Reason__c = shouldBeInactive ? null : 'Reason why not marked as inactive'
                // Additional fields as needed
            );
            loggersToInsert.add(logger);

            // Optionally, mark account as inactive and update it
            if (shouldBeInactive) {
                acc.Active__c = 'false';

                countForInactive++;
            }

            countForProcessedRecord++;
        }

        // Insert logger records
        insert loggersToInsert;
        
        // Update accounts outside of loop
        update scope;
    }

    private Boolean determineIfInactive(Account acc) {
        // Logic to determine if account should be marked as inactive
        // Example: If no pending tasks, events, or cases, mark as inactive
        // You can adjust this logic based on your requirements
        // This is just a placeholder method for demonstration
        return !hasPendingTasksEventsOrCases(acc);
    }

    private Boolean hasPendingTasksEventsOrCases(Account acc) {
        // Example logic to check if account has pending tasks, events, or cases
        // You should implement this method based on your specific requirements
        // This is just a placeholder method for demonstration
        return false; // Placeholder logic
    }

    global void finish(Database.BatchableContext bc) {
        // Optionally, perform any post-processing logic here
    }
}