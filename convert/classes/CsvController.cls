public class CsvController {
    @AuraEnabled(cacheable = True)
    public static List<Account> fetchRecords(){
        System.debug('Data==++>>>'+[SELECT Id, Name, Phone, Type, Industry, Active__c, AnnualRevenue FROM Account LIMIT 120]);
        return[SELECT Id, Name, Phone, Type, Industry, Active__c, AnnualRevenue FROM Account LIMIT 30];  
    }    
}