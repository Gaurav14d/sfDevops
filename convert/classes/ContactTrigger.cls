public class ContactTrigger {
    
    public static void updateParentWithContactSum(List<Contact> contacts) {
        Set<Id> parentIds = new Set<Id>();
        Map<Id, Decimal> parentIdToSumMap = new Map<Id, Decimal>();
        
        for (Contact conObj : contacts) {
            if (conObj.AccountId != null) {
                parentIds.add(conObj.AccountId);
                parentIdToSumMap.put(conObj.AccountId, 0.0); 
            }
        }
        
        List<Contact> relatedContacts = [SELECT Id, AccountId, Value__c FROM Contact WHERE AccountId IN :parentIds];
        
        for (Contact conObj : relatedContacts) {
            if (parentIdToSumMap.containsKey(conObj.AccountId)) {
                parentIdToSumMap.put(conObj.AccountId, parentIdToSumMap.get(conObj.AccountId) + conObj.Value__c);
            }
        }
        
        List<Account> parentsToUpdate = new List<Account>();
        for (Account parent : [SELECT Id, Sum_of_Contact_Value__c FROM Account WHERE Id IN :parentIds]) {
            parent.Sum_of_Contact_Value__c = parentIdToSumMap.get(parent.Id);
            parentsToUpdate.add(parent);
        }
        
        if (!parentsToUpdate.isEmpty()) {
            update parentsToUpdate;
        }
    }
}