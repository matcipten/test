global class BatchDeleteRelazioneGhost implements Database.Batchable<sObject> {

	/* START */

	global final string query;

	global BatchDeleteRelazioneGhost (String q){    
		query = q;     
	}

	global Database.QueryLocator start(Database.BatchableContext BC){

    	/*
    	// Send an email to the Apex job's submitter notifying of job completion.  
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    	String[] toAddresses = new String[] {Admin_Setting__c.getInstance().Email_Notifica_Batch__c};
    	mail.setToAddresses(toAddresses);
    	mail.setSubject('BRUNELLO CUCINELLI - Start Scheduled Batch Delete Relazioni Ghost');
    	mail.setPlainTextBody('The batch Apex job processed');
    	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    	*/
  
		return Database.getQueryLocator(query);
     
	}

	/* EXECUTE */

	global void execute(Database.BatchableContext BC, list<sObject> scope){
    
		if(scope.size()>0){    
			delete scope;    
		}
        
	}

	/* FINISH */

	global void finish(Database.BatchableContext BC){
    
		// Get the ID of the AsyncApexJob representing this batch job  
    	// from Database.BatchableContext.    
    	// Query the AsyncApexJob object to retrieve the current job's information.  

		AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
                      			 TotalJobItems, CreatedBy.Email
                          from AsyncApexJob 
                          where Id =:BC.getJobId()];

		if(a.NumberOfErrors > 0 || Test.isRunningTest()){
			// Send an email to the Apex job's submitter notifying of job completion.  
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      		String[] toAddresses = new String[] {Admin_Setting__c.getInstance().Email_Notifica_Batch__c};
      		mail.setToAddresses(toAddresses);
      		mail.setSubject('BRUNELLO CUCINELLI - Finish Scheduled Batch Delete Relazioni Ghost ' + a.Status);
      		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +' batches with '+ 
                                  a.NumberOfErrors + ' failures.');
      		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });        
		}
    
	}

}