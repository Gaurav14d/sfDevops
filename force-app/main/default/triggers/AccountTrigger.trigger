trigger AccountTrigger on Account (after insert, after update) {
    if (Trigger.isInsert || Trigger.isUpdate) {
        AccountHandler.updateContactTitles(Trigger.new);
    }
}