public class scheduleDemo1 implements schedulable {
    public void execute (schedulableContext sc){
        Database.executeBatch(new batchApex());
    }
    
}