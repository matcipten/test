global class BatchActivityTrackingOnCampaignClosed implements Database.Batchable<sObject>
{
	private Activity_tracking__c CreateNewActivityTracking(CampaignMember myCm,Map<String,String> recordsTypeMapping)
	{
		Activity_tracking__c newActivityTracking = new Activity_tracking__c();
		newActivityTracking.RecordTypeId = recordsTypeMapping.get(myCm.Campaign.RecordTypeId);
		newActivityTracking.Canale__c = myCm.Campaign.Channel__c;
		newActivityTracking.Categoria__c = myCm.Campaign.Categoria__c;
		newActivityTracking.Customer_Name__c = myCm.Contact.AccountId;
		newActivityTracking.Location__c = myCm.Campaign.Location__c;
		newActivityTracking.Campagna__c = myCm.CampaignId;
		newActivityTracking.Location_Instore__c = myCm.Campaign.Location_Instore__c;
		newActivityTracking.Location_Out_of_store__c = myCm.Campaign.Location_Out_of_store__c;
		newActivityTracking.Activity_Date__c = myCm.Campaign.Event_Date__c;
		newActivityTracking.Note_Contatto__c = myCm.Campaign.Description;
		newActivityTracking.Status_Campaign_Member__c =myCm.Status;

		return newActivityTracking;


	}
	global final string query;
	global List<String>  campaignsId;

	global BatchActivityTrackingOnCampaignClosed ( List<String>  campaignsIdParam )
	{
		campaignsId = campaignsIdParam;
		query = 'SELECT Campaign.RecordTypeId, Campaign.Channel__c, Campaign.Categoria__c, '+
		        ' Campaign.Location__c, Contact.AccountId, '+
		        ' CampaignId , Campaign.Location_Instore__c, '+
		        ' Campaign.Location_Out_of_store__c, Status, Campaign.Event_Date__c, Campaign.Description '+
		        ' FROM CampaignMember '+
		        ' WHERE Campaign.Id IN :campaignsId';

		system.debug(query);
	}

	global Database.QueryLocator start(Database.BatchableContext BC){



		return Database.getQueryLocator(query);

	}

	/* EXECUTE */

	global void execute(Database.BatchableContext BC, list<sObject> scope)
	{

		Map<String, Schema.RecordTypeInfo> campaignRecordTypes = Schema.SObjectType.Campaign.getRecordTypeInfosByDeveloperName();
		Map<String, Schema.RecordTypeInfo> activityTrackingRecordTypes = Schema.SObjectType.Activity_Tracking__c.getRecordTypeInfosByDeveloperName();

        Map<String,String> recordsTypeMapping = new Map<String,String>();
        
        for(String campaignRtName : campaignRecordTypes.keySet()){
            RecordTypeInfo activityTrackingRt = activityTrackingRecordTypes.get(campaignRtName);
            if(activityTrackingRt != null){
                recordsTypeMapping.put(campaignRecordTypes.get(campaignRtName).getRecordTypeId(),activityTrackingRt.getRecordTypeId());
            }
        }

		system.debug('start execute');

		List<Activity_tracking__c> ListOfActivityTrackingToCreate = new List<Activity_tracking__c>();


		Map<String,List<String> > accountPerCampaign = new Map<String,List<String> >();
		List<String> accountsIdsTemp = new List<String>();
		//List<CampaignMember> cms = new List<CampaignMember>();

		system.debug('scope size: '+scope.size());

		for(sObject obj : scope)
		{
			CampaignMember cm = (CampaignMember) obj;

			accountsIdsTemp = accountPerCampaign.get(cm.CampaignId);
			if(accountsIdsTemp == null)
				accountsIdsTemp = new List<String>();

			// if(accountPerCampaign.get(cm.CampaignId) == null)
			//  accountsIdsTemp = new List<String>();
			// else
			//  accountsIdsTemp = accountPerCampaign.get(cm.CampaignId);

			accountsIdsTemp.add(cm.Contact.AccountId);

			accountPerCampaign.put(cm.CampaignId,accountsIdsTemp);

			//cms.add(cm);

		}


		system.debug('accountPerCampaign size: '+accountPerCampaign.size());

		if(accountPerCampaign != null && accountPerCampaign.size() >0)
		{
			String queryAT = '';
			queryAT += 'SELECT Id, Campagna__c, Customer_Name__c FROM Activity_Tracking__c WHERE (';
			for(String campaignId : accountPerCampaign.keySet())
			{

				List<String> temp = accountPerCampaign.get(campaignId);
				if(temp != null && temp.size() >0)
				{

					system.debug('*****-----------****');
					system.debug(campaignId);
					system.debug(temp.size());
					system.debug(JSON.serializePretty(temp));
					system.debug('*****-----------****');
					queryAT+= ' (Campagna__c = \''+campaignId+'\' AND Customer_Name__c IN :temp) OR';
				}
			}
			queryAT = queryAT.substring(0,queryAT.length()-3);
			queryAT += ')';
			system.debug('*************queryAT');
			system.debug(queryAT);
			if(queryAT.contains('WHERE ()'))
			{

				for(sObject obj : scope)
				{
					system.debug('WHERE ()');
					CampaignMember myCm = (CampaignMember) obj;

					Activity_tracking__c newActivityTracking = CreateNewActivityTracking(myCm,recordsTypeMapping);

					ListOfActivityTrackingToCreate.add(newActivityTracking);
				}
			}
			else
			{
				system.debug('cut');
				List<Activity_tracking__c> ListOfActivityTrackingExisting = (List<Activity_tracking__c>) Database.query(queryAT);


				system.debug('ListOfActivityTrackingExisting size: '+ListOfActivityTrackingExisting.size());
				system.debug(JSON.serializePretty(ListOfActivityTrackingExisting));


				Map<String,Set<String> > campaignsPerAccountFromExistingActivityTracking =  new Map<String,Set<String> >();
				for(Activity_tracking__c track :ListOfActivityTrackingExisting )
				{

					Set<String> temp = campaignsPerAccountFromExistingActivityTracking.get(track.Customer_Name__c);
					if(temp == null)
						temp = new Set<String>();
					temp.add(track.Campagna__c);


					system.debug('*********');
					system.debug(track.Customer_Name__c);
					system.debug(track.Campagna__c);
					system.debug('*********');

					campaignsPerAccountFromExistingActivityTracking.put(track.Customer_Name__c,temp);
				}


				system.debug('campaignsPerAccountFromExistingActivityTracking size: '+campaignsPerAccountFromExistingActivityTracking.size());

				for(sObject obj : scope)
				{
					CampaignMember myCm = (CampaignMember) obj;
					if(!campaignsPerAccountFromExistingActivityTracking.containsKey((String)myCm.Contact.AccountId)
					   || (campaignsPerAccountFromExistingActivityTracking.get(myCm.Contact.AccountId) != null && !campaignsPerAccountFromExistingActivityTracking.get(myCm.Contact.AccountId).contains(myCm.CampaignId)))
					{
						Activity_tracking__c newActivityTracking = CreateNewActivityTracking(myCm,recordsTypeMapping);

						ListOfActivityTrackingToCreate.add(newActivityTracking);
					}
				}

			}
		}




		// List<Activity_tracking__c> ListOfActivityTrackingExisting =
		// [select id,Campagna__c,Customer_Name__c
		//  from Activity_tracking__c
		//  where Campagna__c IN : campaignsId];

		// Map<String,Set<String> > campaignsPerAccount =  new Map<String,Set<String> >();
		// for(Activity_tracking__c a :ListOfActivityTrackingExisting )
		// {

		//  Set<String> temp = campaignsPerAccount.get(a.Customer_Name__c);
		//  if(temp == null)
		//      temp = new Set<String>();
		//  temp.add(a.Campagna__c);

		//  campaignsPerAccount.put(a.Customer_Name__c,temp);
		// }




		// for(CampaignMember s : scope)
		// {
		//  if(!campaignsPerAccount.containsKey((String)s.Contact.AccountId)
		//     || (campaignsPerAccount.get(s.Contact.AccountId) != null && !campaignsPerAccount.get(s.Contact.AccountId).contains(s.CampaignId)))
		//  {
		//      Activity_tracking__c a = new Activity_tracking__c();
		//      a.RecordType = s.Campaign.RecordType;
		//      a.Canale__c = s.Campaign.Channel__c;
		//      a.Categoria__c = s.Campaign.Categoria__c;
		//      a.Customer_Name__c = s.Contact.AccountId;
		//      a.Location__c = s.Campaign.Location__c;
		//      a.Campagna__c = s.CampaignId;

		//      ListOfActivityTrackingToCreate.add(a);
		//  }
		// }
		system.debug(ListOfActivityTrackingToCreate.size());
		system.debug(ListOfActivityTrackingToCreate);
		insert ListOfActivityTrackingToCreate;


	}

	/* FINISH */

	global void finish(Database.BatchableContext BC){
		AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
		                  TotalJobItems
		                  from AsyncApexJob
		                  where Id =:BC.getJobId()];

		if(a.NumberOfErrors > 0 || Test.isRunningTest()) {
			// Send an email to the Apex job's submitter notifying of job completion.
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {'sfdc.ten@tengroup.it'};
			mail.setToAddresses(toAddresses);
			mail.setSubject('BRUNELLO CUCINELLI - Finish Scheduled Batch Activity Tracking On Campaign Closed ' + a.Status);
			mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +'batches with '+
			                      a.NumberOfErrors + ' failures.');
			if(!Test.isRunningTest())
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}

	}

}