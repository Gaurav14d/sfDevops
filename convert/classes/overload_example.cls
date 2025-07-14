public class overload_example {
    public overload_example(){
        system.debug('No parameter');
    }
    public overload_example(string name){
        system.debug('name:'+name);
    }
    public overload_example(integer age){
        system.debug('age:'+age);
    }
    public overload_example(string name, integer age){
        system.debug('name:'+name +'age:'+age);
    }
}