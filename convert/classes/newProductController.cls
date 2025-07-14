public with sharing class newProductController {
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts() {
        return [SELECT Id, Name, Price__c FROM Product2];
    }

    @AuraEnabled
    public static void addToCart(Id productId) {
        // Add logic to add the product to the cart
    }
}