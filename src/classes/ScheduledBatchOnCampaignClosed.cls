global class ScheduledBatchOnCampaignClosed implements Schedulable {
   global void execute(SchedulableContext sc) {
      Map<String,Campaign> CampaignMaps;
     // List<Campaign> Campaigns = new List<Campaign>();

      try{
         CampaignMaps = new Map<String,Campaign>([select id from Campaign where EndDate = YESTERDAY]);
                  
      }
     catch(Exception e){
        CampaignMaps = new Map<String,Campaign>();
     }
      if(CampaignMaps != null && CampaignMaps.size() > 0)   {
         BatchActivityTrackingOnCampaignClosed b = 
         new BatchActivityTrackingOnCampaignClosed(new List<String>(CampaignMaps.keySet())); 
         database.executebatch(b);
      }
    }

    public static void startScheduleExecute(){
        ScheduledBatchOnCampaignClosed reminder = new ScheduledBatchOnCampaignClosed();
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
        String sch = '0 30 0 ? * * *';
        String jobID = System.schedule('ScheduledBatchOnCampaignClosed', sch, reminder);
    
     
   }
   
}