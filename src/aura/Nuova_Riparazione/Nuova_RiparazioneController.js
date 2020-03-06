({
    myAction : function(component, event, helper) {
    },
    newRepair: function(component,event,helper){
        
        var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/lightning/o/Dettaglio_Riparazione__c/new?nooverride=1&useRecordTypeCheck=1&navigationLocation=LIST_VIEW&backgroundContext=%2Flightning%2Fn%2FHome_Page_Mobile_Client_Advisor"
            });
            urlEvent.fire();
        
    },
    createRecord : function (component, event, helper) {
        var action = component.get("c.getRecordTypeId");
        action.setParams({
            developerName : 'Riparazione'
        });
        
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                    "entityApiName": "Case",
                    "recordTypeId": response.getReturnValue()
                });
                createRecordEvent.fire();
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        
        $A.enqueueAction(action);
        
        
    } 
})