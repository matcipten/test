// DF
@isTest
public class TestScheduledStatusUpdateCampaigns {  
   @isTest static void Test_ScheduledStatusUpdateCampaigns(){
       Profile profile = [Select Id From Profile where Name = 'System Administrator' limit 1];
        User usr1= new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = profile.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser231244@testorg.com');
        
        //all other required field.
        insert usr1;
        
       
       System.runAs(usr1){
       Id devRecordTypeId = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get('Mailing').getRecordTypeId(); 
       Campaign camp1 = new Campaign(Name='Campaign1-TEN',
                                   Status = 'Aborted',
                                   StartDate = System.Today(),
                                   EndDate = System.Today(),
                                     Chat__c = true,
                                     RecordTypeId = devRecordTypeId
                                     
                                  );
      
       insert camp1;    

       
       Campaign camp2 = new Campaign(Name='Campaign2-TEN',
                                   Status = 'Planned',
                                   StartDate = System.Today()-10,
                                   EndDate = System.Today()+ 10, 
                                     Chat__c = true,
                                     RecordTypeId = devRecordTypeId
                                  );
       
       
       insert camp2;   

       Campaign camp3 = new Campaign(Name='Campaign3-TEN',
                                   Status = 'In Progress',
                                   StartDate = System.Today()+ 10,
                                     Chat__c = true,
                                     RecordTypeId = devRecordTypeId
                              
                                  );
     
       
       insert camp3; 

       Campaign camp4 = new Campaign(Name='Campaign4-TEN',
                                   Status = 'In Progress',
                                   EndDate = System.Today()- 10,
                                     Chat__c = true,
                                     RecordTypeId = devRecordTypeId
                                  );
       
       
       insert camp4; 

       

   
       
            
           Test.startTest();
       
           List<Campaign> ListCamp = [Select Id, Name, Status, StartDate,EndDate, RecordTypeId, Chat__c From Campaign];
           system.debug('ListCamp--->'+ListCamp);
    
    
           ScheduledStatusUpdateCampaigns src = new ScheduledStatusUpdateCampaigns(); 
           SchedulableContext sc;
           src.execute(sc);
           Test.stopTest();
       }
       
   }
}