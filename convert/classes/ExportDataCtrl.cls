public class ExportDataCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactData(String recordId) {
        List<Contact> lst_contact = [SELECT Id, Name, Email FROM Contact WHERE AccountId = :recordId];
        return lst_contact;
    }
}