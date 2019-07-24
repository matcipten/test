@isTest
public class OnContentDocumentLinkTriggerHandlerTest {

	@isTest static void testDML(){

		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		Account a;
		System.runAs(usr){

			Map<String,sObject> transAndDetail = AllDataFactory.insert_Transaction_AND_Detail();

			Transaction_Detail__c detail = (Transaction_Detail__c) transAndDetail.get('Transaction_Detail__c');

			ContentVersion cv = AllDataFactory.create_ContentVersion();
			insert cv;

			ContentDocumentLink cdl = AllDataFactory.create_ContentDocumentLink(cv,detail);
			insert cdl;

			delete cdl;

			Attivita_Marketing__c g = AllDataFactory.insert_Gift();

			ContentDocumentLink cdl2 = AllDataFactory.create_ContentDocumentLink(cv,g);
			insert cdl2;

			delete cdl2;
		}


	}

}