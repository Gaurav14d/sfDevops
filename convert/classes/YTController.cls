public with sharing class YTController {
    private static final String SEARCH_URL = 'https://www.googleapis.com/youtube/v3/search';
    private static final String API_KEY = 'AIzaSyBU20aI7wKIq02LIST7zFUViX7yjhcTolg'; 

    @AuraEnabled(cacheable=true)
    public static list<mywrapper> getYTVideos(string searchKey){
        searchKey = searchKey == null ? 'salesforce' : searchKey;
        // YouTube API Callouts
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        Httpresponse res = null;
        String endpoint  = SEARCH_URL +'?part=snippet' +'&maxResults=20' +'&type=video' +'&q=' + EncodingUtil.urlEncode(searchKey, 'UTF-8') +
        '&key=' + API_KEY;

        req.setEndPoint(endpoint);
        req.setMethod('GET');
        res = http.send(req);

        //Deserializing json data
        YoutubeResult.Response f = (YoutubeResult.Response)JSON.deserialize(res.getBody(), YoutubeResult.Response.class);
        List<YoutubeResult.Item> items = F.items;
        //Filling Wrapper Data for lightning component
        List<mywrapper> wrp  = new List<mywrapper>();

        for (YouTubeResult.Item itemObj : items) {
            mywrapper YTWrap = new mywrapper();
            YTWrap.videoId = itemObj.id.videoId;
            YTWrap.description = itemObj.Snippet.description;
            YTWrap.thumbnails = itemObj.Snippet.thumbnails.medium.url;
            YTWrap.title = itemObj.Snippet.title;
            YTWrap.channelTitle = itemObj.Snippet.channelTitle;

            wrp.add(YTWrap);
        }
        return wrp;

    }
    public class myWrapper {
        @AuraEnabled public string videoId {get; set;}
        @AuraEnabled public string description {get;set;}
        @AuraEnabled public string thumbnails {get;set;}
        @AuraEnabled public string title {get;set;}
        @AuraEnabled public string channelTitle {get;set;}
        @AuraEnabled public string publishedAt {get;set;}
    }

}