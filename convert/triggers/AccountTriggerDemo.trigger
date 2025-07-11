trigger AccountTriggerDemo on Account (before insert, after insert) {
    if(trigger.isInsert){
        /*if(trigger.isBefore){
            for(Account accObj : trigger.New){
                if(accObj.Type == 'Customer - Direct'){
                    accObj.UpsellOpportunity__c = 'Yes';
                }
            }
        }
*/
        if(trigger.isAfter){
            List<Contact> listOfContact = new List<Contact>();
            for(Account accObj : trigger.New){
                Contact conObj = new Contact();
                conObj.LastName = accObj.Name;
              //  oppObj.CloseDate = Date.Today();
                //oppObj.StageName = 'Closed Won';
                conObj.AccountId = accObj.Id;
                listOfContact.add(conObj);
                system.debug('akash');
                
            }
            
            system.debug('gaurav' + listOfContact);
            if(!listOfContact.isEmpty()){
                system.debug('dubey');
                    insert listOfContact;
                }
        }
    }
}