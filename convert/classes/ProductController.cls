public with sharing class ProductController {
    

    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts() {
    
        return [SELECT Id, Name, Price__c, Images__c, URL__c FROM Product2 LIMIT 3];
    }
    
    
    @AuraEnabled
    public static void updateProductQuantity(Id productId, Integer newQuantity) {
        Product2 product = [SELECT Id, Quantity__c FROM Product2 WHERE Id = :productId];
        product.Quantity__c = newQuantity;
        update product;
    }   
}