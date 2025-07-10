trigger OrderEventTrigger on Order_Event__e (after insert) {    
    
    List<Task> tasks = new List<Task>();
    
    String usr = UserInfo.getUserId();  
    
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            
            Task ts = new Task();
            ts.Priority = 'Medium';
            ts.Status = 'New';
            ts.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            ts.OwnerId = usr;
            tasks.add(ts);
        }
    }
    
    insert tasks;
    
}