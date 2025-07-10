public class ApprovalProcessHandler {
    public static void submitForApproval(List<Id> opportunityIds) {
        List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();
        
        for (Id oppId : opportunityIds) {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Triggered by Opportunity Trigger');
            req.setObjectId(oppId);
            approvalRequests.add(req);
        }
        
        List<Approval.ProcessResult> approvalResults = Approval.process(approvalRequests);
        
        for (Approval.ProcessResult result : approvalResults) {
            if (!result.isSuccess()) {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error message: ' + error.getMessage());
                }
            }
        }
    }
}