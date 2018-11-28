Global class ScheduledStatusUpdateCampaigns implements Schedulable {
/*

Codice per schedulare la classe con Anonymous block
(sec, min, h, day of month, month, day of week, year)

Documentazione : http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_scheduler.htm

ScheduledStatusUpdateCampaigns m = new ScheduledStatusUpdateCampaigns();
String sch = '0 50 11 * * ? *';
system.schedule('SCHEDULED BATCH STATUS UPDATE CAMPAIGN', sch, m);

*/
   
    global void execute(SchedulableContext ctx) {
        string query        = '';       
        
        query += 'select Id, startDate, EndDate, IsActive, Status ';
        query += 'from Campaign ';
        query += 'where Status != \'Aborted\'';

        system.debug('TEN query: ' + query);    

        BatchStatusUpdateCampaigns batchApex = new BatchStatusUpdateCampaigns(query);
        ID batchprocessid = Database.executeBatch(batchApex,200);   
 
    }
    
}