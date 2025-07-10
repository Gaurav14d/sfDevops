public class Future_Method {
    @future
    public  static void callme(){
        system.debug('callme 1');
        system.debug('callme 2');
    }
    @future
    public static void show(){
        system.debug('show 1');
        system.debug('show 2');
    }
    public void invoke(){
        system.debug('invoke 1');
          system.debug('invoke 2');
        callme();
          system.debug('invoke 3');
          system.debug('invoke 4');
        show();
          system.debug('invoke 5');
          system.debug('invoke 6');
    }

}