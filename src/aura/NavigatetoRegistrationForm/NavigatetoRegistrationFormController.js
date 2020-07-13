({
    doInit : function(component, event, helper) {
         var myPageRef = component.get("v.pageReference");
        if(myPageRef){
            var sectionBool = myPageRef.state.c__showSecondSection;
            component.set("v.showSecondSection",sectionBool);
        }else{
           component.set("v.showSecondSection",false);
        }
        console.log('recordId ' + component.get("v.recordId"));
        if (component.get("v.recordId") === undefined) {
			component.set("v.textButton", "Digital customer card");
        } else {
			component.set("v.textButton", "Update Customer");        
        }       
        var action = component.get("c.getUserCorrectInterface");
        var pageReference;
        var tipo;
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var link =response.getReturnValue();
                console.log('VS link: '+link);
                if(link == 'Normal User'){
                    pageReference = {
                        type: 'standard__component',
                        attributes: {
                            componentName: 'c__RegistrationForm',
                        },
                        state: {
                            
                        }
                    };
                    tipo="Normal User";
                }else{
                    pageReference=link;
                    tipo="Url";
                }
                component.set("v.pageReference", pageReference);
                component.set("v.type",tipo);
            }
        });
        $A.enqueueAction(action); 
	},    
    
    openActionWindow : function(component, event, helper) {        
        console.log('recordId ' + component.get("v.recordId"));
         var navService = component.find("navService");
        // var pageReference = {
        //     type: 'standard__component',
        //     attributes: {
        //         componentName: 'c__RegistrationForm',
        //     },
        //     state: {
                
        //     }
        // };
        var pageReference = component.get("v.pageReference");
        var tipo = component.get("v.type");
        
    
        if(tipo=="Normal User"){
            component.set("v.pageReference", pageReference);
            navService.navigate(pageReference);
        }else{
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
            "url": pageReference
            });
            urlEvent.fire();
        }

        
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
    openActionWindowNew : function(component, event, helper) {        
        console.log('recordId ' + component.get("v.recordId"));
         var navService = component.find("navService");
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__NavigatetoRegistrationForm',
            },
            state: {
                "c__showSecondSection" : "true"
            }
        };
        component.set("v.pageReference", pageReference);
        navService.navigate(pageReference);
       
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