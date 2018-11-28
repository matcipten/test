// DF
@isTest
public class TestScheduledStatusUpdateCampaigns {  
   @isTest static void Test_ScheduledStatusUpdateCampaigns(){
       
       
       Campaign camp1 = new Campaign(Name='Campaign1-TEN',
                                   Status = 'Aborted',
                                   StartDate = System.Today(),
                                   EndDate = System.Today()
                                  );
      
       insert camp1;    

       
       Campaign camp2 = new Campaign(Name='Campaign2-TEN',
                                   Status = 'Planned',
                                   StartDate = System.Today()-10,
                                   EndDate = System.Today()+ 10 
                                  );
       
       
       insert camp2;   

	   Campaign camp3 = new Campaign(Name='Campaign3-TEN',
                                   Status = 'In Progress',
                                   StartDate = System.Today()+ 10
                              
                                  );
     
       
       insert camp3; 

	   Campaign camp4 = new Campaign(Name='Campaign4-TEN',
                                   Status = 'In Progress',
                                   EndDate = System.Today()- 10
                                  );
       
       
       insert camp4; 

	   
     
       
       Test.startTest();
       
       List<Campaign> ListCamp = [Select Id, Name, Status, StartDate,EndDate, RecordTypeId From Campaign];
       system.debug('ListCamp--->'+ListCamp);


       ScheduledStatusUpdateCampaigns src = new ScheduledStatusUpdateCampaigns(); 
       SchedulableContext sc;
       src.execute(sc);
       Test.stopTest();
       
	   
   }
}