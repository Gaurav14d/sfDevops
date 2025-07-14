public class AccountInactiveScheduler implements Schedulable{
    public void execute(SchedulableContext sc) {
        AccountInactive.getNewRecord();
        }
    }