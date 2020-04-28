({
	doInit: function(component, event, helper) {


		console.log('pageReference');
		let pageReference = component.get('v.pageReference');
		console.log(pageReference);

		if (pageReference != undefined && pageReference != null && pageReference.state != undefined && pageReference.state != null && pageReference.state.c__isFullPage != undefined && (pageReference.state.c__isFullPage == 'true' || pageReference.state.c__isFullPage == true))
			component.set('v.isFullPage', true);
		else
			component.set('v.isFullPage', false);
		helper.doInitHelper(component, event);



	},
	loadMoreData: function(component, event, helper) {
		// let pageReference = component.get('v.pageReference');
		if (component.get('v.isFullPage') != undefined && component.get('v.isFullPage') && (component.get('v.isFullPage') == 'true' || component.get('v.isFullPage') == true)) {
			//Display a spinner to signal that data is being loaded
			event.getSource().set("v.isLoading", true);
			//Display "Loading" when more data is being loaded
			component.set('v.loadMoreStatus', 'Loading');
			helper.fetchData(component, event).then(
				$A.getCallback((data) => {
					console.log(component.get('v.data').length);
					console.log(component.get('v.totalNumberOfRows'));
					if (component.get('v.data').length >= component.get('v.totalNumberOfRows')) {
						component.set('v.enableInfiniteLoading', false);
						component.set('v.loadMoreStatus', 'No more data to load');
					} else {
						var currentData = component.get('v.data');
						//Appends new data to the end of the table
						var newData = currentData.concat(data);
						component.set('v.data', newData);
						component.set('v.loadMoreStatus', 'Please wait ');
					}
					event.getSource().set("v.isLoading", false);
				}));
		}
	},

	goToFullComponent: function(component, event, helper) {
		let pageReference = {
			type: "standard__component",

			attributes: {
				componentName: 'c__HomeBirthdayNoAssociate',
			},
			state: {
				c__isFullPage: 'true'
			}
		};
		component.set("v.pageReference", pageReference);
		event.preventDefault();
		component.find("navService").navigate(pageReference);
		helper.doInitHelper(component, event);

	},

	refreshCmp: function(component, event, helper) {

		console.log('pageReference');
		let pageReference = component.get('v.pageReference');
		console.log(pageReference);

		$A.get("e.force:refreshView").fire();

		
		component.set('v.isFullPage', false);
		if (pageReference != undefined && pageReference != null && pageReference.state != undefined && pageReference.state != null && pageReference.state.c__isFullPage != undefined && (pageReference.state.c__isFullPage == 'true' || pageReference.state.c__isFullPage == true))
			component.set('v.isFullPage', true);
		else
			component.set('v.isFullPage', false);

		console.log(component.get('v.isFullPage'));
	},

	handleRowAction: function(component, event, helper) {
		let action = event.getParam('action');
		let row = event.getParam('row');
		console.log(JSON.stringify(row));
		console.log(JSON.stringify(action));	
		console.log(JSON.stringify(action.name));	
		let recordId = row.Id;
		if (action.name == 'openRecord') {
			console.log('ok');
			let pageReference = {
				type: "standard__recordPage",
				attributes: {
					recordId: recordId,
					objectApiName: "Account",
					actionName: "view"
				}
			};
			component.set("v.pageReference", pageReference);
			event.preventDefault();
			component.find("navService").navigate(pageReference);
		}
	}
})