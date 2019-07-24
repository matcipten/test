@IsTest
public class myActiveCampaignsControllerTest {

	@isTest static void testGetLabels(){
		MyActiveCampaignsController.getLabels();
	}


	@isTest static void testGetTotalCount(){
		try{

			MyActiveCampaignsController.getTotalCount();
		}
		catch(Exception e) {

		}

		// User usr = AllDataFactory.create_User();
		// insert usr;

		// Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		// insert profileSettings;

		// // Test.startTest();
		// System.runAs(usr){

		AllDataFactory.insert_MyActiveCampaignAndMembers();
		// }
		Test.startTest();
		MyActiveCampaignsController.getTotalCount();
		Test.stopTest();
	}

	@isTest static void testGetMyActiveCampaigns(){
		try{

			MyActiveCampaignsController.getMyActiveCampaigns(1,0);
		}
		catch(Exception e) {

		}

		// User usr = AllDataFactory.create_User();
		// insert usr;

		// Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		// insert profileSettings;

		// // Test.startTest();
		// System.runAs(usr){

		AllDataFactory.insert_MyActiveCampaignAndMembers();
		// }
		Test.startTest();
		MyActiveCampaignsController.getMyActiveCampaigns(1,0);
		Test.stopTest();
	}

}