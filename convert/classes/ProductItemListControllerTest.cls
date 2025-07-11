@isTest
private class ProductItemListControllerTest {
    
    // Mock HTTP response generator
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String body;
        
        MockHttpResponseGenerator(Integer statusCode, String body) {
            this.statusCode = statusCode;
            this.body = body;
        }
        
        public HTTPResponse respond(HttpRequest request) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody(body);
            response.setStatusCode(statusCode);
            return response;
        }
    }
    
    @isTest
    static void testGetProducts() {
        // Create test data
        List<Product__c> products = new List<Product__c>();
        products.add(new Product__c(Name = 'Product 1', Prices__c = 100.00, Images__c = 'image1.jpg'));
        products.add(new Product__c(Name = 'Product 2', Prices__c = 200.00, Images__c = 'image2.jpg'));
        insert products;
        
        Test.startTest();
        // Call the getProducts() method
        List<ProductItemListController.ProductListWrapper> productWrappers = ProductItemListController.getProducts();
        Test.stopTest();
        
        // Assertions
        System.assertEquals(2, productWrappers.size(), 'Expected 2 products');
        
        // Verify the first product details
        Product__c product1 = products[0];
        ProductItemListController.ProductListWrapper wrapper1 = productWrappers[0];
        System.assertEquals(product1.Id, wrapper1.Id, 'Product 1 Id should match');
        System.assertEquals(product1.Name, wrapper1.name, 'Product 1 Name should match');
        System.assertEquals(product1.Prices__c, wrapper1.price, 'Product 1 Price should match');
        System.assertEquals(product1.Images__c, wrapper1.image, 'Product 1 Image should match');
        System.assertEquals(0, wrapper1.quantity, 'Product 1 Quantity should be initialized to 0');
        System.assertEquals(0, wrapper1.quantity2, 'Product 1 Quantity2 should be initialized to 0');
        
        // Verify the second product details
        Product__c product2 = products[1];
        ProductItemListController.ProductListWrapper wrapper2 = productWrappers[1];
        System.assertEquals(product2.Id, wrapper2.Id, 'Product 2 Id should match');
        System.assertEquals(product2.Name, wrapper2.name, 'Product 2 Name should match');
        System.assertEquals(product2.Prices__c, wrapper2.price, 'Product 2 Price should match');
        System.assertEquals(product2.Images__c, wrapper2.image, 'Product 2 Image should match');
        System.assertEquals(0, wrapper2.quantity, 'Product 2 Quantity should be initialized to 0');
        System.assertEquals(0, wrapper2.quantity2, 'Product 2 Quantity2 should be initialized to 0');
    }
    
    @isTest
    static void testGetProducts_Exception() {
        Test.startTest();
        // Mock an exception scenario
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, '{"error":"Internal Server Error"}'));
        
        try {
            List<ProductItemListController.ProductListWrapper> productWrappers = ProductItemListController.getProducts();
            // If we expect an exception and it does not occur, fail the test
            System.assert(false, 'Expected an exception but did not occur');
        } catch (AuraHandledException e) {
            // Expected behavior
            System.assert(e.getMessage().contains('Internal Server Error'), 'Expected error message not found');
        }
        
        Test.stopTest();
    }
}