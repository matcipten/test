global class ScheduledBatchDeleteRelazioneGhost implements Schedulable {

	/*

	Codice per schedulare la classe con Anonymous block
	(sec, min, h, day of month, month, day of week, year)

	Documentazione : http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_scheduler.htm

	ScheduledBatchDeleteRelazioneGhost m = new ScheduledBatchDeleteRelazioneGhost();
	String sch = '0 50 11 * * ? *';
	system.schedule('SCHEDULED BATCH DELETE RELAZIONE GHOST', sch, m);

	*/
   
	global void execute(SchedulableContext ctx) {

		string query = 'SELECT Id FROM Relazione_Ghost__c';
    
		BatchDeleteRelazioneGhost batchApex = new BatchDeleteRelazioneGhost(query);
		ID batchprocessid = Database.executeBatch(batchApex);   
 
    } 

}