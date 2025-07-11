public class ThisKeyword_Example{
    public string name;
    public string city;
    public string place;
    public ThisKeyword_Example(string empname, string city, string place){
        name=empname;
       city=city;
        this.place=place;   
    }
    public void show(){
        system.debug('name:'+name);
        system.debug('name:'+city);
        system.debug('name:'+place);
    }
}