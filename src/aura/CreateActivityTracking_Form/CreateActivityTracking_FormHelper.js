({
	handleSubmitHelper: function(component, event, helper) {


		let cmpEvent = component.getEvent("saveActivityTrackingEvent");
		cmpEvent.setParams({
			"newActivityTracking": component.get('v.newActivityTracking'),
			"locationVisibility": component.get('v.locationVisibility'),
			"giftType":component.get('v.giftSelected')
		});
		cmpEvent.fire();


	},


	calculateLocationVisibility: function(component, categoria, location, tipoDevName) {
		let locationVisibility = 0;

		// if (categoria == 'OT_Sartoria Solomeo'
		// 	|| categoria == 'OT_Trunk Show/Collection Preview'
		// 	|| categoria == 'OT_Eating out/Vip dinner or lunch'
		// 	|| categoria == 'OT_Spend time with clients') {

		// 	if (location == 'Instore')
		// 		locationVisibility = 6;
		// 	else if (location == 'Out of store')
		// 		locationVisibility = 5;
		// 	else
		// 		locationVisibility = 4;
		// }

		// else if (categoria == 'OT_Tour Visit') {
		// 	locationVisibility = 1;
		// }



		// if (tipoDevName == 'One_To_One') {
		// 	if (categoria == 'OT_Proposte di stile'
		// 		|| categoria == 'OT_Product Home Delivery'
		// 		|| categoria == 'OT_Repair follow-up'
		// 		|| categoria == 'OT_Follow-up after store visit'
		// 		|| categoria == 'OT_Thank you note'
		// 		|| categoria == 'OT_Solomeo Experience'
		// 		|| categoria == 'OT_Attending Corporate Event'
		// 		|| categoria == 'OT_Greetings'
		// 		|| categoria == 'OT_Gifting') {
		// 		locationVisibility = 0;
		// 	}
		// 	else if (categoria == 'OT_Tour Visit') {
		// 		locationVisibility = 1;
		// 	}

		// }
		// else {
		// 	if (location == 'Instore')
		// 		locationVisibility = 6;
		// 	else if (location == 'Out of store')
		// 		locationVisibility = 5;
		// 	else
		// 		locationVisibility = 4;
		// }






		if (tipoDevName == 'One_To_One' && categoria == 'OT_Tour Visit')
			locationVisibility = 1;

		else if (tipoDevName != 'One_To_One' || (
			categoria != 'OT_Proposte di stile'
			&& categoria != 'OT_Product Home Delivery'
			&& categoria != 'OT_Repair follow-up'
			&& categoria != 'OT_Follow-up after store visit'
			&& categoria != 'OT_Thank you note'
			&& categoria != 'OT_Solomeo Experience'
			&& categoria != 'OT_Attending Corporate Event'
			&& categoria != 'OT_Greetings'
			&& categoria != 'OT_Gifting'
			&& categoria != 'OT_Keep in Touch'
		)) {
			if (location == 'Instore')
				locationVisibility = 6;
			else if (location == 'Out of store')
				locationVisibility = 5;
			else
				locationVisibility = 4;
		}

		component.set('v.locationVisibility', locationVisibility);
	}

})