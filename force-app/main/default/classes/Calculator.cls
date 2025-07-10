public class Calculator {
    public Decimal aval{set;get;}
    public Decimal bval{set;get;}
    public Decimal result{set;get;}
    
    public void add(){
        result=aval+bval;
    }
    public void cancel(){
        aval=null;
        bval=null;
        result=null;
    }

}