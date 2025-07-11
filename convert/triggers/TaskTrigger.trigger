trigger TaskTrigger on Task (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        taskTriggerHandler.setTaskPriorityToHigh(trigger.New);
        
    }
}