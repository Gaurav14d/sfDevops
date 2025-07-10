public class caseTriggerHandler {
    public static void handleCaseActivity(List<Case> newCase){
        for(Case cObj : newCase){
            if(cObj.Origin == 'Phone'){
                cObj.Priority = 'High';
                    }
            else{
                cObj.Priority = 'Low';
                
            }
            
        }
    }
    
}