public class futureMethod {
    public futureMethod(){
        takeShower();
        getReady();
        laundry();
        goToWedding();
    }
    
    public static void takeShower(){
        System.debug('shower.');
    }
    public static void getReady(){
        System.debug('Ready.');
    }
    @future
    public static void laundry(){
        System.debug('laundry');
    }
    public static void goToWedding(){
        System.debug('Wedding');
    }
    
}