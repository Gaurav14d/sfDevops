public class taskTriggerHandler {
    public static void setTaskPriorityToHigh(List<Task> newTasks){
        for(Task tObj : newTasks){
            tObj.Priority = 'High';

 
        }
    }
}