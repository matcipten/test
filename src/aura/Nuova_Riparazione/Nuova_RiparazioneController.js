({
	myAction : function(component, event, helper) {
		
	},
   createRecord : function (component, event, helper) {
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Case",
        "recordTypeId": $A.get("$Label.c.RecordTypeId_Riparazioni")
    });
    createRecordEvent.fire();
} 
})