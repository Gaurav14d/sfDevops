public class scheduleDemo implements schedulable {
    
    public void execute(schedulableContext sc){
        delete[SELECT Id FROM Contact WHERE Phone = 'Null'];
    }
    
}