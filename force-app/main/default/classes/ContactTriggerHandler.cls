public class ContactTriggerHandler {
    public static void handleContactRecord(List<Contact> newContacts){
        for(Contact conObj : newContacts){
            if(conObj.AccountId == Null){
                conObj.addError('Contact record cannot be created');
            }
            
        }
    }
   
}