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
    static void testGetRandomRecipe_Success() {
        String mockResponse = '{"recipes": [{"title": "Test Recipe"}]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, mockResponse));
        SpoonacularAPI.getRandomRecipe();
    }

    @isTest
    static void testGetRandomRecipe_Failure() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(400, 'Bad Request'));
        SpoonacularAPI.getRandomRecipe();
    }

    @isTest
    static void testGetRandomRecipeInformation_Success() {
        String mockResponse = '{"recipes": [{"title": "Test Info Recipe"}]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, mockResponse));
        SpoonacularAPI.getRandomRecipeInformation();
    }

    @isTest
    static void testGetRandomRecipeInformation_Failure() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'Internal Server Error'));
        SpoonacularAPI.getRandomRecipeInformation();
    }

    @isTest
    static void testGetRandomRecipeIngredients_Success() {
        String mockResponse = '[{"title": "Ingredient Recipe 1"}, {"title": "Ingredient Recipe 2"}]';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, mockResponse));
        SpoonacularAPI.getRandomRecipeIngredients('chicken,cheese');
    }

    @isTest
    static void testGetRandomRecipeIngredients_Failure() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(403, 'Forbidden'));
        SpoonacularAPI.getRandomRecipeIngredients('chicken,cheese');
    }
}