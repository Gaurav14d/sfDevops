public class static_method {
    public integer aval;
    public static integer bval;
    public void callme(){
        system.debug('this is call me method');
    }
    public static void invoke(){
        integer age =10;
        integer amount =1000;
        system.debug('this is invoke method 1');
        system.debug('this is invoke method 2');
    }
    public void show(){
        aval=10;
        bval=20;
    }
    public static void display(){
        bval=bval+40;
    }

}