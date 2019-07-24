global class ResubmitRussianWebServiceRequest implements Database.Batchable<sObject>,Database.AllowsCallouts,Schedulable {
    global String query;

	global void execute(SchedulableContext ctx) {
        ResubmitRussianWebServiceRequest batch = new ResubmitRussianWebServiceRequest();
        Database.executeBatch(batch);
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
   		return Database.getQueryLocator(query);
	}

    
    global void finish(Database.BatchableContext bc) {
    }
    
    global ResubmitRussianWebServiceRequest() {
    this.query  = 'SELECT CreatedDate,Id,ErrorMessage__c,HttpResponseCode__c,ResubmitNumber__c,Name,Status__c,XMLRequest__c,XMLResponse__c FROM RussianWebServerLog__c WHERE HttpResponseCode__c != 200';

	}
    
    global void execute(Database.BatchableContext bc, List<RussianWebServerLog__c> scope) {

        for (RussianWebServerLog__c log : scope) {
         	RussianWebServer.RussianWebServerXMLInvocation(log);
        }
    }
}