public class TwitterVFController {
    public String twitterHandle { get; set; }
    
    public TwitterVFController() {
        this.twitterHandle = 'twitter';
    }
    
    public TwitterVFController(String handle) {
        this.twitterHandle = handle;
    }
}