public class MethodOverloading_Example {
    public void call(){
        system.debug('I am without parameter');
    }
    public void call(string name){
        system.debug(name);
    }
    public void call(integer age){
        system.debug(age);
}
    public void call(string name, integer age){
        system.debug(name+''+ age);
    }
    public void call(integer age, string name){
        system.debug(age+''+ name);
    }

}