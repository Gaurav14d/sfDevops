public class ContentDocumentHandler {
    
    public static List<Account> getAccountsNotLinkedToContentDocument() {
        
        ContentDocument contentDocument = [SELECT Id FROM ContentDocument LIMIT 1];
        List<ContentDocumentLink> listOfContentDocumentLink = [SELECT LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId = :contentDocument.Id];
        Set<Id> setOfId = new Set<Id>();
        for (ContentDocumentLink cdl : listOfContentDocumentLink) {
            setOfId.add(cdl.LinkedEntityId);
        }
        List<Account> listOfAccount = [SELECT Id, Name FROM Account WHERE Id NOT IN :setOfId];
        return listOfAccount;
    }
}