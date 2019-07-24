@isTest
private class TestBatchOnCampaignClosed {
 
    
       // List<Activity_tracking__c> ListOfActivityTrackings = new List<Activity_tracking__c>();
        List<Campaign> ListOfCampaignMembers = new List<Campaign>();
    	       


 	static testmethod void test()
    {
        
        
         String personAccountRecordTypeId =  Account.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
         Account acc = new Account(
            FirstName = 'TestName',
            LastName = 'TestSurname',
            Sesso__c = 'M',
            PersonEmail =  'personalEmail@gmail.com',
            Phone = '12345679',
            PersonMobilePhone = '16844838',
            RecordTypeId = personAccountRecordTypeId,
            Privacy3__c = true,
            PersonBirthdate = Date.Today().addDays(1)
            );
			//insert acc;
        
         Account acc1 = new Account(
            FirstName = 'TestName1',
            LastName = 'TestSurname1',
            Sesso__c = 'M',
            PersonEmail =  'personal1Email@gmail.com',
            Phone = '123456791',
            PersonMobilePhone = '168448381',
            RecordTypeId = personAccountRecordTypeId,
            Privacy3__c = true,
            PersonBirthdate = Date.Today().addDays(1)
            );
			//insert acc1;
         
         String CampaignRecordType =  Campaign.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get('One_To_One').getRecordTypeId();
         Campaign c = new Campaign(
            Name = 'Campaign a',
            Quantity__c = '1',
            Email__c = true,
            RecordTypeId = CampaignRecordType,
            Categoria__c = 'OT_Tour Visit',
            Location__c = 'Out of store',
            Location_Out_of_store__c = 'aaa',
            StartDate = Date.Today().addDays(-1),
            EndDate = Date.Today().addDays(1)
            );
            insert c;


            Contact cont = new Contact( LastName = 'LastName' , AccountId = acc.Id  );
            insert cont;
                                        
            Contact cont1 = new Contact( LastName = 'LastName1', AccountId = acc1.Id  );
            insert cont1;
            

            CampaignMember cm = new CampaignMember(
            CampaignId = c.Id,
            ContactId = cont.Id
            );
           // insert cm;

            CampaignMember cm1 = new CampaignMember(
            CampaignId = c.Id,
            ContactId = cont1.Id
            );
           // insert cm1;


        List<CampaignMember> ListOfCampaignMembers = new List<CampaignMember>();
        ListOfCampaignMembers.add(cm);
        ListOfCampaignMembers.add(cm1); 
        insert ListOfCampaignMembers;

        List<Campaign> ListOfCampaigns = new List<Campaign>();
        ListOfCampaigns.add(c);
        List<String> EmptyListOfCampaignIds = new List<String>();
        List<String> ListOfCampaignIds = new List<String>();

        for(Campaign ca : ListOfCampaigns)
        {
           ListOfCampaignIds.add((String)ca.Id);
        }
        //insert ListOfCampaigns;
        //insert ListOfCampaignIds;
    
    
   
           
		
		Test.startTest();
        
        	        
        	
			BatchActivityTrackingOnCampaignClosed uca = new BatchActivityTrackingOnCampaignClosed(ListOfCampaignIds);
        	Id batchId = Database.executeBatch(uca);	
        
        	
			BatchActivityTrackingOnCampaignClosed uca1 = new BatchActivityTrackingOnCampaignClosed(EmptyListOfCampaignIds);
        	Id batchId1 = Database.executeBatch(uca1);

			//Id batchInstanceId = Database.executeBatch(new BatchActivityTrackingOnCampaignClosed(ListOfCampaignIds), 3);


     
           
        Test.stopTest();
    }
       
    
}