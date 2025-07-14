trigger CaseTrigger on Case (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        caseTriggerHandler.handleCaseActivity(trigger.New);
        
    }

}