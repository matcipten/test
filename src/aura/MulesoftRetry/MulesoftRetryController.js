({
	doInit : function(component, event, helper) {
			console.log('ci sono riuscito');
		var action = component.get("c.doRetry");
        action.setCallback(this, function (response) {
			console.log('success: '+response.getState());
            if (response.getState() == "SUCCESS") { 
				console.log('ci sono riuscito success');
				window.history.back()  
            }
            // console.log("Vs opts 1: "+JSON.stringify(opts));
		});
		$A.enqueueAction(action);
		console.log('ci sono riuscito2');
		}
		
	})