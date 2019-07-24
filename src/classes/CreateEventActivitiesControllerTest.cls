@isTest
public class CreateEventActivitiesControllerTest {

	@isTest static void testGetLabels(){
		CreateEventActivitiesController.getLabels();
	}

	@isTest static void testGetCostoRT(){
		CreateEventActivitiesController.getCostoRT();
	}

	@isTest static void testGetCampaignId(){

		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		Account a;
		System.runAs(usr){

			try{

				CreateEventActivitiesController.getCampaignId(null);

			}
			catch(Exception e) {

			}


			Activity_Tracking__c at1 = AllDataFactory.create_Activity_Tracking('One_To_One');
			String activityId = CreateActivityTrackingController.createNewActivityTracking(at1);

			Test.startTest();

			CreateEventActivitiesController.getCampaignId(activityId);
             Map<String,String> tipi = new  Map<String,String>();
            tipi = CreateEventActivitiesController.getTypePicklist('a' , 'b',activityId);

			Test.stopTest();
		}

	}
    	

}