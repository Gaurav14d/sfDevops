public class SpoonacularAPI {
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    private static final String API_KEY = '2b3d546f99e3496cb45f844c4d2b348c';
    
    public static void getRandomRecipe() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('Response Body: ' +response.getStatusCode());
        if (response.getStatusCode() == 200) {
            System.debug('response' + response.getBody());
            
        }
    }   
    
    public static void getRandomRecipeInformation() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(SPOONACULAR_API + '/recipes/random?apiKey='+API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('Response body:' + response.getStatusCode());
        if(response.getStatusCode() == 200){
            System.debug('response' + response.getBody());
        }
    }
    
}