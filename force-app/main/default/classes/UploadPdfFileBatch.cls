public class UploadPdfFileBatch implements Database.Batchable<Account> {
    
    public Iterable<Account> start(Database.BatchableContext bc) {
        return [SELECT Id, Name FROM Account WHERE Id NOT IN (SELECT FirstPublishLocationId FROM ContentVersion WHERE FirstPublishLocation.Type = 'Account' ) LIMIT 10];
    }
    public void execute(Database.BatchableContext bc, List<Account> newAccount) {
        
        List<ContentVersion> contentVersions = new List<ContentVersion>();
        system.Debug('newAccount'+ newAccount);
        for (Account oppObj : newAccount) {
            ContentVersion cv = new ContentVersion();
            cv.Title = 'Sample PDF';
            cv.PathOnClient = 'sample.pdf';
            cv.VersionData = Blob.valueOf('Sample PDF content');
            cv.IsMajorVersion = true;
            cv.FirstPublishLocationId = oppObj.Id;
            
            
            contentVersions.add(cv);
        }
        
        insert contentVersions;
    } 
    public void finish(Database.BatchableContext context) {
        System.debug('Batch job finished successfully');
    }
}