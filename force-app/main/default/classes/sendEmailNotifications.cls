/*@Name -  Gaurav Dubey
 @Author - Gaurav Dubey
 @Description - Send email notifications to account owners when their accounts are marked as inactive
  @Date - 29/05/2024
  @IsWorking  - Yes 
 */
public with sharing class sendEmailNotifications {
    public static void SendEmailNotifications(List<Account> accounts) {
        try {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Account Inactive Notification');
            email.setPlainTextBody('Your account has been marked as inactive. Please contact your administrator for more information.');

            for (Account acc : accounts) {
                email.setToAddresses(new String[] { acc.Owner.Email });
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage> { email });
            }
        } catch (Exception e) {
            // Handle exceptions here
            System.debug('Error sending email: '+ e.getMessage());
        }
    }
}