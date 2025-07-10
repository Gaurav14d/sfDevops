public with sharing class GoogleSearchService {
    public class SearchResult {
        @AuraEnabled public String title;
        @AuraEnabled public String link;
        @AuraEnabled public String snippet;
    }

    @AuraEnabled
    public static List<SearchResult> searchGoogle(String query) {
        List<SearchResult> results = new List<SearchResult>();
        try {
            String url = 'https://www.googleapis.com/customsearch/v1?q=' + EncodingUtil.urlEncode(query, 'UTF-8') +
                         '&key=YOUR_API_KEY&cx=YOUR_SEARCH_ENGINE_ID';
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            if (res.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                if (jsonResponse.containsKey('items')) {
                    for (Object item : (List<Object>) jsonResponse.get('items')) {
                        Map<String, Object> result = (Map<String, Object>) item;
                        SearchResult searchResult = new SearchResult();
                        searchResult.title = (String) result.get('title');
                        searchResult.link = (String) result.get('link');
                        searchResult.snippet = (String) result.get('snippet');
                        results.add(searchResult);
                    }
                }
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
        return results;
    }
}