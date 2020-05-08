({
	changeCategoria : function(component,event,helper){

		var cmpEvent = component.getEvent("categoryChosenEvent");
		let temp = {};
		temp.label = event.getSource().get('v.label');
		temp.value = event.getSource().get('v.value');
		console.log(temp.value);
		if(temp.value != undefined && temp.value.includes('EV_')){
			console.log(component.get('v.EVCategorie'));
			for(let i=0; i < component.get('v.EVCategorie').length; i++){
				let obj = component.get('v.EVCategorie')[i];
				if(obj.value == temp.value){
					temp.realvalue = obj.realvalue;
					break;
				}
			}
		}
		else if(temp.value != undefined && temp.value.includes('MA_')){
			console.log(component.get('v.MACategorie'));
			for(let i=0; i < component.get('v.MACategorie').length; i++){
				let obj = component.get('v.MACategorie')[i];
				if(obj.value == temp.value){
					temp.realvalue = obj.realvalue;
					break;
				}
			}
			
		}
		else if(temp.value != undefined && temp.value.includes('OT_')){
			for(let i=0; i < component.get('v.OTCategorie').length; i++){
				console.log(component.get('v.OTCategorie'));
				let obj = component.get('v.OTCategorie')[i];
				if(obj.value == temp.value){
					temp.realvalue = obj.realvalue;
					break;
				}
			}
		}

		component.set('v.categoria',temp.realvalue);
        cmpEvent.setParams({
			"categoria":JSON.stringify(temp)
		});
		console.log(temp);
		cmpEvent.fire();
	}
})