({
	doInit : function(component, event, helper) {
		helper.setPicklist(component,event);
		helper.getInfo(component,event);
	},

	closeModel: function(){
		var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
	},

	submitDetails: function(cmp, event, helper){
		// console.log("VS id:"+cmp.get("v.recordId"));
		var bool=cmp.get("v.userHasMangerId") 
		if (!bool){			
			cmp.set("v.showError",true);
			cmp.set("v.errorMessage",$A.get("$Label.c.Error_Message_Discount_Request"));
		}else {
			cmp .set("v.showError",false);
			var action = cmp.get("c.updateAccount");
			action.setParams({
				"recordId": cmp.get("v.recordId"),
				"categoria": cmp.find('discount').get('v.value'),
				"motivo":cmp.find('note').get('v.value')
			});

			action.setCallback(this, function(response) {
				var state = response.getState();
				console.log("Vs state submit: "+state);
				if(state =='SUCCESS'){
					$A.get("e.force:closeQuickAction").fire();
					$A.get('e.force:refreshView').fire();
					
				}
			
			});

			$A.enqueueAction(action);
		}	
	}
})