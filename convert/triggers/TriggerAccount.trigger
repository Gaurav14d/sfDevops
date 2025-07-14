trigger TriggerAccount on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        AccountHandler.updateRelatedOpportunities(trigger.New);
    }
    
    
}