public class ProductItemListController {
    @AuraEnabled(cacheable = true)
    public static List<ProductListWrapper> getProducts(){
        
        List<ProductListWrapper> listOfProduct = new List<ProductListWrapper>();
        for(Product__c productItem : [SELECT Id, Name, Prices__c, Images__c FROM  Product__c ]){
            ProductListWrapper productWrapObj = new ProductListWrapper(productItem.Id, productItem.Name, productItem.Prices__c ,productItem.Images__c ,0,0);
            listOfProduct.add(productWrapObj);                
        }
        system.debug(listOfProduct);
        return listOfProduct;
        
    }
    public class ProductListWrapper{
        @AuraEnabled public String Id {get;set;}
        @AuraEnabled public String name {get;set;}
        @AuraEnabled public Decimal price {get;set;}
        @AuraEnabled public String image {get;set;}
        @AuraEnabled public Integer quantity {get;set;}
        @AuraEnabled public Integer quantity2 {get;set;}
        
        public ProductListWrapper(String Id, String name, Decimal price, String image, Integer quantity, Integer quantity2){
            this.Id = Id;
            this.name = name;
            this.price = price;
            this.image = image;
            this.quantity = quantity;
            this.quantity2 = quantity2;
        }
    }
}