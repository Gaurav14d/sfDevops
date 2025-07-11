public class SOQL_Example {
    public List<Account> accounts {set;get;}
    public  SOQL_Example(){
        accounts=[SELECT Id, Name, Industry, Rating FROM Account];
    }

}