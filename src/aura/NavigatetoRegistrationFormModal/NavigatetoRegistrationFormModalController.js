({
    doInit : function(component, event, helper) {
        console.log('recordId ' + component.get("v.recordId"));
        if (component.get("v.recordId") === undefined) {
			component.set("v.textButton", "Create new Customer");
        } else {
			component.set("v.textButton", "Update Customer");        
        }        
	},
    
    
    openActionWindow : function(component, event, helper) {        
        console.log('recordId ' + component.get("v.recordId"));
        if (component.get("v.recordId") === undefined) {
            window.open('/c/RegistrationFormApp.app', '_self');
            /*
            $A.get("e.force:closeQuickAction").fire();
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": window.location.protocol + "//" + window.location.host + "/c/RegistrationFormApp.app"
            });
            urlEvent.fire();
            */
        } else {
            window.open('/c/RegistrationFormApp.app?Id=' + component.get("v.recordId"), '_self');
            /*
            $A.get("e.force:closeQuickAction").fire();
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": window.location.protocol + "//" + window.location.host + "/c/RegistrationFormApp.app?Id=" + component.get("v.recordId")
            });
            urlEvent.fire();
            */
        }
    },
    
    checkBrowser: function(component) {
        var device = $A.get("$Browser.formFactor");
        alert("You are using a " + device);
    }
    
})