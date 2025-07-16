public class SpoonacularAPI {
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    private static final String API_KEY = '2b3d546f99e3496cb45f844c4d2b348c';

    public static void getRandomRecipe() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/random?apiKey=' + API_KEY);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        System.debug('Status: ' + response.getStatusCode());
        if (response.getStatusCode() == 200) {
            System.debug('Success response: ' + response.getBody());
        } else {
            System.debug('Failed response: ' + response.getBody());
        }
    }

    public static void getRandomRecipeInformation() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/random?apiKey=' + API_KEY);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        System.debug('Status: ' + response.getStatusCode());
        if (response.getStatusCode() == 200) {
            System.debug('Success response: ' + response.getBody());
        } else {
            System.debug('Failed response: ' + response.getBody());
        }
    }

    public static void getRandomRecipeIngredients(String ingredients) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/findByIngredients?ingredients=' + ingredients + '&apiKey=' + API_KEY);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        System.debug('Status: ' + response.getStatusCode());
        if (response.getStatusCode() == 200) {
            System.debug('Success response: ' + response.getBody());
        } else {
            System.debug('Failed response: ' + response.getBody());
        }
    }
}