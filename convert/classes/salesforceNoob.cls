public class salesforceNoob {
    
    public static void testData(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
        system.debug('accList'+accList);
        
        
        /*   for(Account accObj : accList){
System.debug('accList'+accList);
}
}*/
        
    }   
}