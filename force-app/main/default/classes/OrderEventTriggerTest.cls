@isTest
public class OrderEventTriggerTest {
    @isTest
    static void testOrderEventTrigger() {
        // Create a test user
        User testUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        
        // Create a test Order_Event__e platform event
        List<Order_Event__e> events = new List<Order_Event__e>();
        Order_Event__e testEvent = new Order_Event__e(
            Has_Shipped__c = true,
            Order_Number__c = 'ORD12345'
        );
        events.add(testEvent);
        
        // Test the trigger by inserting the event
        Test.startTest();
        EventBus.publish(events);
        Test.stopTest();
        
        // Verify that a Task is created
        Task createdTask = [SELECT Id, Subject, OwnerId, Status, Priority FROM Task WHERE Subject LIKE '%ORD12345%' LIMIT 1];
        
        System.assertNotEquals(null, createdTask, 'Task should be created');
        System.assertEquals('Medium', createdTask.Priority, 'Priority should be Medium');
        System.assertEquals('New', createdTask.Status, 'Status should be New');
        System.assertEquals(testUser.Id, createdTask.OwnerId, 'OwnerId should match the current user');
    }
}