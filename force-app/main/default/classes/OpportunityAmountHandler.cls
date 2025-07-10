public class OpportunityAmountHandler{
public static void UpdateOpportunity(list<Opportunity> myOpportunity){
    for(Opportunity opp : myOpportunity){
    if(opp.stageName == 'closed Won'){
        opp.Amount  = 10000;
    }
}
}
}