public with sharing class OnCaseTriggerHandler {

    public static void CloseTicketCallout(list<Case> ListCase){

		WebService_Settings__c wss 	= WebService_Settings__c.getValues('General');
		RecordTypeSetting__c rts	= RecordTypeSetting__c.getValues('General');

 		string OMSendpoint = wss.OMS_Endpoint__c;

 		Map<Id, Case> caseMap = new Map<Id, Case>(ListCase);
 		Map<Id, String> caseCommentMap = new Map<Id, String>();
 		Set<Id> caseIds = caseMap.keySet();

 		for(CaseComment cc : [SELECT CommentBody,CreatedById,CreatedDate,Id,ParentId 
 			FROM CaseComment 
 			where ParentId = :caseIds
 			and CreatedDate = today
 			order by CreatedDate ASC
 			]){
 			caseCommentMap.put(cc.ParentId, cc.CommentBody);
 		}

 		System.debug('caseCommentMap : ' + caseCommentMap);
 
		for(Case c:ListCase){

			String internalComments = caseCommentMap.get(c.id);

			//String request = '{"orderId": "' + c.Id_Ordine__c + '", "returnId": "' + c.Id_Reso__c + '","notes": '+ internalComments +'}';
			String request = '{';
			request += '"ticketId":"' + c.casenumber + '"';
 			request += ',"status":"CHIUSO"';
			request += ',"orderId": "' + ( String.isNotBlank(c.Id_Ordine__c) ? c.Id_Ordine__c : '') + '"';
			//request += String.isNotBlank(c.Id_Ordine__c) && String.isNotBlank(c.Id_Reso__c) ? ',' : '';
			request +=  ',"returnId": "' + ( String.isNotBlank(c.Id_Reso__c) ? c.Id_Reso__c : '' )  + '"';
			//request += String.isNotBlank(c.Id_Ordine__c) || String.isNotBlank(c.Id_Reso__c) ? ',' : '';
			request +=  ',"notes": ' + ( String.isNotBlank(internalComments) ? JSON.serialize(internalComments) : '""' );
			request += '}';

 			System.debug('request : ' + request);
										
			OnCaseTriggerHandler.runCallout(OMSendpoint, request, c.id);
		}
        
    }
    
	@future (callout=true)
    public static void runCallout(string endpoint, string strRequest, string CaseId){ 

        string resultCode 		= '';
        string logResult		= '';
		datetime startCallout	= system.now();
		
		Http http;
		HTTPResponse res;
		
		try{
	
	   		HttpRequest req = new HttpRequest();
			req.setEndpoint(endpoint);
			req.setMethod('POST');
			req.setHeader('Content-Type', 'application/json');
			req.setBody(strRequest);
				
			http 	= new Http();
			res 	= http.send(req);
	    	
	    	system.debug('TEN req: ' + req);
	    	system.debug('TEN req.body: ' + req.getBody());
	    	system.debug('TEN res: ' + res);
			
			logResult = res.toString() + ',' + res.getBody();
	    	resultCode 	= '' + res.getStatusCode();
	    
	    } catch(Exception e) {
	       	logResult += '[ERROR]; Exception: ' + e.getMessage();
	       	resultCode = 'ERROR';

	       	System.debug('logResult:' + logResult);
	    
	    } finally {
	       	OnCaseTriggerHandler.insertWSLog(CaseId, 
	       									strRequest,
	       									logResult,  
	       									startCallout, 
	       									resultCode,
	       									endpoint);
	       									
	    }
   	
   	}

    public static void insertWSLog(	string objId, 
    								string Req, 
    								string logRes,
    								DateTime sCallout, 
    								string resCode,
    								string endp) {
        
        Web_Service_Log__c wslog = new Web_Service_Log__c(
		Record_Id__c        = objId,
		Endpoint__c			= endp,
		Request__c        	= Req,
        Result_Detail__c    = logRes,
        Timestamp__c        = sCallout,
        Result_Code__c      = resCode
        );
        insert wslog;
    }
    
}