@isTest
private class TestScheduledBatchOnCampaignClosed {
   
    
    @isTest   
   public static void  testschedule() {
       Test.StartTest();
       
		 List<Campaign> camps = new List<Campaign>();
        	//Date closeDate = Date.today().addDays(-7);
      		  for (Integer i=0; i<10; i++) {
          	  Campaign campaign = new Campaign(	
            	    Name = 'Campaign ' + i,
            	    Status = 'Completed',
	                Email__c = true,
                  	EndDate = Date.Today().addDays(-1)
           	 );
              insert campaign;
          	  camps.add(campaign);
        	}
       		
       		// Map<String,Campaign> CampaignMaps;
       		 //CampaignMaps = new Map<String,Campaign>([select id from Campaign where EndDate = YESTERDAY]);
       		//insert CampaignMaps;

      
            
			ScheduledBatchOnCampaignClosed sh1 = new ScheduledBatchOnCampaignClosed();      
 			String sch = '0 0 23 * * ?';
     	   	system.schedule('Test check', sch, sh1);
       		ScheduledBatchOnCampaignClosed.startScheduleExecute();
			Test.stopTest();

       
      
}
}