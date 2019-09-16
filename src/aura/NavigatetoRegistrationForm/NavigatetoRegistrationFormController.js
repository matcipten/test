({
    doInit : function(component, event, helper) {
        console.log('recordId ' + component.get("v.recordId"));
        if (component.get("v.recordId") === undefined) {
			component.set("v.textButton", "Digital customer card");
        } else {
			component.set("v.textButton", "Update Customer");        
        }        
	},    
    
    openActionWindow : function(component, event, helper) {        
        console.log('recordId ' + component.get("v.recordId"));
         var navService = component.find("navService");
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__RegistrationForm',
            },
            state: {
                
            }
        };
        component.set("v.pageReference", pageReference);
        navService.navigate(pageReference);
         
            /*
            $A.get("e.force:closeQuickAction").fire();
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": window.location.protocol + "//" + window.location.host + "/c/RegistrationFormApp.app"
            });
            urlEvent.fire();
            
            var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Case",
        "recordTypeId": $A.get("$Label.c.RecordTypeId_Riparazioni")
    });
    createRecordEvent.fire();
            
            var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "/c/RegistrationFormApp.app"
        });
        urlEvent.fire();
            
             */
       
    },
    
    openActionComponent : function(component, event, helper) {        
        console.log('recordId ' + component.get("v.recordId"));
        if (component.get("v.recordId") === undefined) {
            var newEvent = $A.get("e.force:navigateToComponent");
            newEvent.setParams({
                componentDef: "c:RegistrationForm",
                componentAttributes: {
                    //Set you attributes here if required.
                }
            });
            newEvent.fire();
        } else {
            var newEvent = $A.get("e.force:navigateToComponent");
            newEvent.setParams({
                componentDef: "newComponent",
                componentAttributes: {
                    //Set you attributes here if required.
                }
            });
            newEvent.fire();
        }
    },
    
    checkBrowser: function(component) {
        var device = $A.get("$Browser.formFactor");
        alert("You are using a " + device);
    },
    
    navHome : function (component, event, helper) {
        
        var urlEvent = $A.get("e.force:navigateToURL");
        if(urlEvent) {
            urlEvent.setParams({
                "url": "/c/RegistrationFormApp.app"
            });
            
            urlEvent.fire();
        } else {
            window.location = "/c/RegistrationFormApp.app"
        }
}
    
})