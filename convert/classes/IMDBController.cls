public class IMDBController {
    @AuraEnabled(cacheable=true)
    public static string getMovies(string searchText){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('callout:IMDB/imdb/imdbSearchByName?query='+searchText);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('Status Code: '+response.getStatusCode());
        System.debug('Body: '+response.getBody());
        if (response.getStatusCode() == 200) {
            return response.getBody();
        }
        else{
            return 'Error Code :'+response.getStatusCode();
        }   
    }
}