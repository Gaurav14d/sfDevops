trigger PreventAccountDeletion on Account (before delete) {
    for (Account accObj : Trigger.old) {
        accObj.addError(Label.Prevent_Account_Deletion);
    }
}