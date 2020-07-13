({
	setPicklist: function(component, event) {
		var action = component.get("c.getPicklistValue");
		var opts =[];
		opts.push({ value: '', label: '--None--' });
		action.setCallback(this, function(response) {
			var state = response.getState();
			if(state =='SUCCESS'){
				var allValues= response.getReturnValue()
				for (var i in allValues){
					// console.log('VS1 allValues: '+allValues[i]);
					var arr = allValues[i].ProposedCustomerCategory__c.split("|");
					for (var j in arr){
						// console.log('VS1 arr: '+arr[j]);
						var sconto=arr[j].split(":");
						opts.push({ value: sconto[1], label: sconto[0] });
					}
				}			
			}
			
			component.set("v.options",opts);
		});
		$A.enqueueAction(action);
		return opts;
	},

	getInfo: function(component, event) {
		var action = component.get("c.getUserInfo");	
		action.setCallback(this, function(response) {
			var state = response.getState();
			console.log("State: "+state);
			if(state =='SUCCESS'){
				var resp= response.getReturnValue();
				console.log(resp);
				if(resp.ManagerId != undefined){
					console.log("VS ManagerID: "+resp.ManagerID);
					component.set("v.userHasMangerId",true);	
				}				
			}else {
				var toastEvent = $A.get("e.force:showToast");
				toastEvent.setParams({
					"title": "Error!",
					"message": "Contact system administrator."
				});
				toastEvent.fire();
			}	
		});
		$A.enqueueAction(action);
		
	}
})