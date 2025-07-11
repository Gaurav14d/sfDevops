public class redirectPg {
Public redirectPg(ApexPages.StandardController controller){

}

Lead lead;

Public PageReference savelead(){
    insert lead;
    PageReference reRend = new PageReference('https://abc.xyz/');
    reRend.setRedirect(true);
    return reRend;
}}