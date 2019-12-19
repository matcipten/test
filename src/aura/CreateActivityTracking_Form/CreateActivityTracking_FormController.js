({

	doInit: function(component, event, helper) {

		let cmpEvent = component.getEvent("showSpinner");
		cmpEvent.fire();

		let newActivityTracking = component.get('v.newActivityTracking');


		let categoria = newActivityTracking.Categoria__c;

		if(categoria.includes('EV_')){
			console.log(component.get('v.EVCategorie'));
			for(let i=0; i < component.get('v.EVCategorie').length; i++){
				let obj = component.get('v.EVCategorie')[i];
				if(obj.value == categoria){
					categoria = obj.realvalue;
					break;
				}
			}
		}
		else if(categoria.includes('MA_')){
			console.log(component.get('v.MACategorie'));
			for(let i=0; i < component.get('v.MACategorie').length; i++){
				let obj = component.get('v.MACategorie')[i];
				if(obj.value == categoria){
					categoria = obj.realvalue;
					break;
				}
			}
			
		}
		else if(categoria.includes('OT_')){
			for(let i=0; i < component.get('v.OTCategorie').length; i++){
				console.log(component.get('v.OTCategorie'));
				let obj = component.get('v.OTCategorie')[i];
				if(obj.value == categoria){
					categoria = obj.realvalue;
					break;
				}
			}
		}




		let location = newActivityTracking.Location__c;
		
		let tipoDevName = component.get("v.tipoDevName");
		console.log('------------------------------- '+tipoDevName );
		//Akshay 12/02/2019 -- 8
	
		if(categoria == 'OT_Attending Corporate Event'){
			var filter =  ' AND Categoria__c =\''+categoria+'\'';
			component.set("v.filter",filter);
		}else if(tipoDevName != 'One_To_One'){
			component.set("v.showCampaignLookup", true);
			var filter =  ' AND Categoria__c =\''+categoria+'\'';
			component.set("v.filter",filter);
		}else{
			component.set("v.showCampaignLookup", false);
			var action = component.get("c.setCampaignOTWithSelectedRecord");
        action.setParams({ 
			categoriaValue : categoria,
			tipoDevNameValue : tipoDevName
		 });

       
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
             
                var result = response.getReturnValue();
				if(result != null){
					newActivityTracking.Campagna__c = result;
				}
            }
            else if (state === "INCOMPLETE") {
               
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
		

		helper.calculateLocationVisibility(component, categoria, location,tipoDevName);

		categoria = categoria.split('_')[1];
		component.set('v.categoriaToShow', categoria);

		if (component.get('v.accountId') != undefined && component.get('v.accountId') != null && component.get('v.accountId') != '') {
			newActivityTracking.Customer_Name__c = component.get('v.accountId');
		}
		component.set('v.newActivityTracking', newActivityTracking);

		console.log('newActivityTracking');
		console.log(JSON.parse(JSON.stringify(newActivityTracking)));

		console.log(tipoDevName);
		console.log(categoria);
		if(tipoDevName == 'One_To_One' && categoria == 'Gifting'){
			console.log('pippo');
			var actionGift = component.get('c.getGiftTipologiaPicklist');
			actionGift.setCallback(this,response =>{
				let state = response.getState();
				if(state === 'SUCCESS' && component.isValid()){
					let giftPicklist = response.getReturnValue();
					let tempList = [];
					tempList.push({label:'',value:''});
					for(var key in giftPicklist){
						tempList.push({label:giftPicklist[key], value:key});
					}

					component.set('v.giftPicklist',tempList);

				}
			});

			$A.enqueueAction(actionGift);
		}



	},

	onload: function(component, event, helper) {

		let cmpEvent = component.getEvent("hideSpinner");
		cmpEvent.fire();

	},


	goToPreviousStep: function(component, event, helper) {
		let cmpEvent = component.getEvent("goToPreviousStepEvent");
		cmpEvent.setParams({
			"step": 1
		});
		cmpEvent.fire();
	},

	toggleLocation: function(component, event, helper) {
		let location = event.getSource().get('v.value');
		var newActivityTracking = component.get('v.newActivityTracking');
		if (location == 'Instore') {
			newActivityTracking.Location_Out_of_store__c = null;
		}
		else if (location == 'Out of store') {
			newActivityTracking.Location_Instore__c = null;
		}

		let tipoDevName = component.get("v.tipoDevName");

		let categoria = newActivityTracking.Categoria__c;

		helper.calculateLocationVisibility(component, categoria, location,tipoDevName);
	},

	validate: function(component, event, helper) {
		event.preventDefault();
		let inputs = component.find('requiredField');

		let continueToSave = true;
		let messagesToShow = '';

		var newActivityTracking = component.get("v.newActivityTracking");
        console.log(newActivityTracking.Campagna__c);
        if(newActivityTracking.Campagna__c ==  null || newActivityTracking.Campagna__c == '' || newActivityTracking.Campagna__c == undefined ){
            continueToSave = false;
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error",
                "message": "Prima di procedere con il salvataggio dell'activity tracking creare la relativa campagna di default"
            });
            toastEvent.fire();
        }

		if (inputs != null && inputs.length > 0) {
			for (let i = 0; i < inputs.length; i++) {
				let singleInput = inputs[i];
				let value = singleInput.get("v.value");
				/*if (value != undefined && value != null && value.length > 0)
					value = nameValue[0];*/
				if ($A.util.isUndefined(value) || $A.util.isEmpty(value)) {
					//singleInput.set("v.errors", [{ message: "Devi inserire un valore" }]);
					$A.util.addClass(singleInput, 'slds-has-error');
					continueToSave = false;
				}
				else {
					$A.util.removeClass(singleInput, 'slds-has-error');
					if (Array.isArray(value) && value.length > 0) {
						value = value[0];
						singleInput.set("v.value", value);
					}
				}

			}
		}

		console.log('continueToSave: ' + continueToSave);
		console.log('messagesToShow: ' + messagesToShow);
		if (continueToSave == true) {
			helper.handleSubmitHelper(component, event, helper);
		}


	},

	handleError: function(cmp, event, helper) {
		var comp = event.getSource();
		$A.util.addClass(comp, "error");
	},

	handleClearError: function(cmp, event, helper) {
		var comp = event.getSource();
		$A.util.removeClass(comp, "error");
	},

	handleSubmit: function(component, event, helper) {
		helper.handleSubmitHelper(component, event, helper);
	}
})