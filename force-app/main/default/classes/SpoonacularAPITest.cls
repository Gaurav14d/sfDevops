@isTest
private class SpoonacularAPITest {
    
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String responseBody;
        
        MockHttpResponseGenerator(Integer statusCode, String responseBody) {
            this.statusCode = statusCode;
            this.responseBody = responseBody;
        }
        
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(statusCode);
            res.setBody(responseBody);
            return res;
        }
    }
    
    @isTest
    static void testGetRandomRecipe() {
        
        String mockResponse = '{"recipe": "test recipe"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, mockResponse));
        
        SpoonacularAPI.getRandomRecipe();
        
    }
    
    @isTest
    static void testGetRandomRecipeInformation() {
        
        String recipeId = '12345';
        String mockResponse = '{"recipe": "test recipe info"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, mockResponse));
        
        SpoonacularAPI.getRandomRecipeInformation(recipeId);
        
    }
    
    @isTest
    static void testGetRandomRecipeIngredients() {
        
        String ingredients = 'chicken,cheese';
        String mockResponse = '[{"recipe": "test recipe 1"}, {"recipe": "test recipe 2"}]';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, mockResponse));
        
        
        SpoonacularAPI.getRandomRecipeIngredients(ingredients);
        
        
    }
}