public class ProductInfo { 
   public string name;
    public decimal price;
    public integer quantity;
    public ProductInfo(){
        name='vipul';
        price=100;
        quantity=1234;
        system.debug('name of product from constructor:'+name);
        system.debug('name of product from constructor:'+price);
        system.debug('name of product from constructor:'+quantity);
    } 
    public void show(){
        system.debug('name of product :'+name);
        system.debug('name of product :'+name);
        system.debug('name of product :'+name);
    }
}