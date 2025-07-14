@isTest
public class UploadPdfFileBatchTest {
    @isTest
    static void testUploadPdfFileBatch() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;
        
        List<ContentVersion> existingCVs = [SELECT Id FROM ContentVersion WHERE FirstPublishLocationId IN :testAccounts];
        System.assertEquals(0, existingCVs.size(), 'No ContentVersion records should exist before running the batch');
        
        Test.startTest();
        UploadPdfFileBatch batch = new UploadPdfFileBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        
        List<ContentVersion> createdCVs = [SELECT Id, Title, FirstPublishLocationId FROM ContentVersion WHERE FirstPublishLocationId IN :testAccounts];
        System.assertEquals(testAccounts.size(), createdCVs.size(), 'Each Account should have one ContentVersion');
        
        for (ContentVersion cv : createdCVs) {
            System.assertEquals('Sample PDF', cv.Title, 'Title should match');
        }
    }
}