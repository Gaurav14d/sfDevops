//Whenever an Opportunity is marked as Closed Won, automatically create a Task assigned to the Opportunity’s Account Owner to follow up
// with the customer in 3 days.
trigger OpportunityTrigger on Opportunity (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        OpportunityTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}