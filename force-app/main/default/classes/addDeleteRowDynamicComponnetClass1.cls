@isTest
public class addDeleteRowDynamicComponnetClass1 {
    
    @AuraEnabled
    public static String insertAccounts(List<Account> accList) {
        System.debug('insertAccounts ==> ');
        System.debug('accList ==> ' + accList);
        String response = '';
        
        try {
            // Convert NumberOfEmployees to Integer (assuming it's a String)
            for (Account acc : accList) {
                acc.NumberOfEmployees = Integer.valueOf(acc.NumberOfEmployees); 
            }
            
            // Insert the list of accounts
            insert accList;
            response = 'SUCCESS';
        } catch (Exception ex) {
            System.debug('Exception ==> ' + ex.getMessage());
            response = ex.getMessage(); // Capture the exception message
        }
        
        return response;
    }
}