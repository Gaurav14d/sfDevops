public class Dynamic_SOQL {
    public string name {set;get;}
    public string industry {set;get;}
    public string query {set;get;}
    public list<Account>accounts {set;get;}
    
    public void search(){
        query = 'Select id, name, industry, phone FROM Account';
        if(name !=''&& industry !=''){
            query=query+'Where name=\''+name+'\'and Industry=\''+industry+'\'';
           } else{
                if(name !=''){
                    query=query+'Where name=\''+name+'\'';
                   } else{
                        if(industry !=''){
                            query=query+'Industry=\''+industry+'\'';
                }
            }
        }
    }
}