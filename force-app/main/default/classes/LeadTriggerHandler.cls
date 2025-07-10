public with sharing class LeadTriggerHandler {
    public static void handleLeadDeleteActivity(List<Lead> newLeadRecords){
        for(Lead l : newLeadRecords){
            if(l.status == 'Working - Contacted'){
                l.addError('Lead cannot be deleted');
            }
        }
        
    }
    /* public static void handleLeadActivity(List<Lead> newLeads){
List<Task> taskListToInsert = new List<Task>();
for(Lead lObj : newLeads){
if(lObj.Status == 'Working - Contacted'){
Task tObj = new Task();
tObj.Priority = 'High'; 
tObj.OwnerId = lObj.OwnerId;
tObj.Description = 'Split the revenue amongst the team with high priority';
tObj.Status = 'Not Started'; 
tObj.Subject = 'Split Revenue Amongst Team'; 
tObj.WhoId = lObj.Id; 
taskListToInsert.add(tObj);     
}
}

if(!taskListToInsert.isEmpty()){
insert taskListToInsert;
}
}
/* public static void handleLeadActivity(List<Lead> newLeads){
for(Lead lObj : newLeads){
if(lObj.Industry == 'HealthCare'){
lObj.LeadSource = 'Purchased List';
lObj.SICCode__c = '1100';
lObj.Primary__c = 'Yes';
}
}


public static void setLeadStatus(List<Lead> newLeads){
for(Lead lObj : newLeads){
lObj.Status = 'Working-Contacted';
}
}
public static void handleLeadActivity(List<Lead> newRecords){
List<Task> taskRecords = new List<Task>();
try {
for(Lead lObj : newRecords) {
Task tObj = new Task();
tObj.Priority = 'High'; 
tObj.OwnerId = lObj.OwnerId;
tObj.Description = 'Split the revenue amongst the team with high priority';
tObj.Status = 'Not Started'; 
tObj.Subject = 'Split Revenue Amongst Team'; 
tObj.WhoId = lObj.Id; 
taskRecords.add(tObj); 
}

if(!taskRecords.isEmpty()) {
insert taskRecords;
}
} catch (Exception e) {
System.debug('An error occurred: ' + e.getMessage());
}
}*/
}