({
	doInit : function(component, event, helper) {
        helper.fetchUser(component);
	},

    onLogout : function(component, event, helper) {
        console.log("Logout success.");
        helper.changeOwner(component);
        var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "mode": 'pester',
                "duration": 3000,
                "title": "Attenzione",
                "message": "I casi a te assegnati ritorneranno nella coda",
                "type":'warning'
            });
			toastEvent.fire();
		console.log("Vs user id: " +component.get("v.userId"));

		
    },

    onWorkAccepted: function(component, event, helper) {        
        helper.setCheckHours(component,event);
    }
})