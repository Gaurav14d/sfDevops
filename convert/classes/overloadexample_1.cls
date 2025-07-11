public class overloadexample_1 {
    public overloadexample_1(){
        system.debug('No parameters:');
}
    public overloadexample_1(string name){
        system.debug('name:'+name);
    }
    public overloadexample_1(integer age){
        system.debug('age:'+age);
    }
    public overloadexample_1(string name, integer age){
    system.debug('name:'+name+'age:'+age);
    }
    public overloadexample_1(integer age, string name){
        system.debug('age:'+age+'name:'+name);
    }

}