global class BatchStatusUpdateCampaigns  implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    /* START */

  global final string query;

  global BatchStatusUpdateCampaigns (String q){    

     query = q;

  }

  global Database.QueryLocator start(Database.BatchableContext BC){

    /*
    // Send an email to the Apex job's submitter notifying of job completion.  
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {'dario.finotti@tengroup.it'};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Brunello Cucinelli - Start Scheduled Batch Update Campaigns');
    mail.setPlainTextBody('The batch Apex job processed');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    */
    
    return Database.getQueryLocator(query);
     
  }

/* EXECUTE */

  global void execute(Database.BatchableContext BC, list<sObject> scope){
    
    list<Campaign> UpdateCampaign = new list<Campaign>();
    
    for(sObject s:scope){
    
      Campaign c = (Campaign)s; 

     
		if( c.Startdate  > System.today() && c.Status!='Planned'){
			c.Status='Planned';
			UpdateCampaign.add(c);
            system.debug('Change status Planned'+ UpdateCampaign);
		}
		else if(c.Startdate  <= System.today() && c.EndDate >= System.today() && c.Status!='In Progress' ){
			c.Status='In Progress';
			UpdateCampaign.add(c);
            system.debug('Change status In progress'+ UpdateCampaign);
		}
        else if(c.EndDate < System.today() && c.Status!='Completed'){
			c.Status='Completed';
            c.IsActive=false;
			UpdateCampaign.add(c);
            system.debug('Change status Completed'+ UpdateCampaign);
		}
        else{
			system.debug('Do  nothing');
		}   
     		
	  
    }


    if(UpdateCampaign.size()>0){    
      update UpdateCampaign;
    }
    
  }

/* FINISH */

  global void finish(Database.BatchableContext BC){
    
    // Get the ID of the AsyncApexJob representing this batch job  
    // from Database.BatchableContext.    
    // Query the AsyncApexJob object to retrieve the current job's information.  

	BC_Settings__c AC = BC_Settings__c.getInstance();

    AsyncApexJob a = [  Select   Id, Status, NumberOfErrors, JobItemsProcessed,
                  TotalJobItems, CreatedBy.Email
              from AsyncApexJob where Id =:BC.getJobId()];

    if(a.NumberOfErrors > 0){

      // Send an email to the Apex job's submitter notifying of job completion.  
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      String[] toAddresses = new String[] {AC.Email_Batch_Class_Campaigns__c};
      mail.setToAddresses(toAddresses);
      mail.setSubject('Brunello Cucinelli - Finish Scheduled Batch Status Update Campaigns ' + a.Status);
      mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +' batches with '+ a.NumberOfErrors + ' failures.');
      Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });    
        
    }
    
  }
    
}