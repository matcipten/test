({

	doInit: function(component, event, helper) {
		console.log('aaaa');
		console.log(component.get('v.picklistLabelsCanaleC'));
	},

	changeCanale: function(component, event, helper) {

		console.log('aaaa');
		console.log(component.get('v.picklistLabelsCanaleC'));

		var cmpEvent = component.getEvent("channelChosenEvent");
		let temp = {};
		temp.label = event.getSource().get('v.label');
		temp.value = event.getSource().get('v.value');
		console.log(temp);
		// component.set('v.canaleValue', temp.value);
		console.log(component.get('v.canale'));
		cmpEvent.setParams({
			"canale": JSON.stringify(temp)
		});
		cmpEvent.fire();
	},

	// changeCanaleImage: function(component, event, helper) {
	// 	console.log('aaaa');
	// 	console.log(component.get('v.picklistLabelsCanaleC'));

	// 	var cmpEvent = component.getEvent("channelChosenEvent");
	// 	let temp = {};
	// 	temp.label = event.getSource().get('v.alternativeText');
	// 	temp.value = event.getSource().get('v.alternativeText');
	// 	console.log(temp);
	// 	component.set('v.canale', temp.value);
	// 	console.log(component.get('v.canale'));
	// 	cmpEvent.setParams({
	// 		"canale": JSON.stringify(temp)
	// 	});
	// 	cmpEvent.fire();
	// },
})