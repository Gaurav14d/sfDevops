trigger LeadTrigger on lead (before delete) {
    
    if(trigger.isBefore && trigger.isDelete){
        LeadTriggerHandler.handleLeadDeleteActivity(trigger.Old);    
    } 
}