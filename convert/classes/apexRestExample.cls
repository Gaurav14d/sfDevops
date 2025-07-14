@RestResource(urlMapping='/accountoops/*')
global class apexRestExample {global static List<Opportunity> getRelatedOops(){
    	RestRequest req = RestContext.request;
    String accountId = req.requestURI.substring(req.requestURI.lastIndexof('/')+1);
    return[SELECT Id, Name, Amount FROM Opportunity WHERE AccountId=:accountId];
        }

}