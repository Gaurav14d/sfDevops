trigger ContactTrigger on Contact (after insert, after update, after delete) {
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete) {
            List<Contact> contacts = Trigger.isDelete ? Trigger.old : Trigger.new;
            
            ContactTrigger.updateParentsWithContactSum(contacts);
        }
    }
}