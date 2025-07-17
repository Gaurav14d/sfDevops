/**
* @File Name : AccountLWCController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : July 17, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | July 17, 2025 |   | Initial Version
**/

public class AccountLWCController {
	@AuraEnabled(cacheable=true)
	public static List<Account> getAccountList() {
		return [
			SELECT Id, Name, Industry, Phone, Type, Website, Rating, AccountNumber, AnnualRevenue, BillingCity, BillingCountry FROM Account WHERE Industry != Null 
		];
	}
}