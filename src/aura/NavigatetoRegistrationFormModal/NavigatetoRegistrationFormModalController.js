({
    doInit : function(component, event, helper) {
        console.log('recordId ' + component.get("v.recordId"));
        if (component.get("v.recordId") === undefined) {
            component.set("v.textButton", "Create new Customer");
        } else {
            component.set("v.textVal", "Are you sure you want to proceed with the customer update?");  
            component.set("v.textButton", "Update Customer");        
        }        
    },
    
    
    openActionWindow : function(component, event, helper) { 
        
        
        var navService = component.find("navService");
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__RegistrationForm',
            },
            state: {
                "c__recordId": component.get("v.recordId")
            }
        };
        component.set("v.pageReference", pageReference);
        navService.navigate(pageReference);
        /*
        var action = component.get("c.setCacheInLocal");
        action.setParams({
            "accId": component.get("v.recordId")
            
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
            }
            
        }
                          );
        $A.enqueueAction(action);
        
        
        var navService = component.find("navService");
        var pageReference = {
            "type": "standard__navItemPage",
            "attributes": {
                "apiName": "Registration_Form"
            }, 
            "state": {
                "Id" :component.get("v.recordId")
            }
        };
        
        navService.navigate(pageReference);*/
        
    },
    
    checkBrowser: function(component) {
        var device = $A.get("$Browser.formFactor");
        alert("You are using a " + device);
    }
    
})