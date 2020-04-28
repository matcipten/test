({

	doInitHelper: function(component, event) {

		// var totalCnt = component.get("c.getTotalCount");
		// totalCnt.setCallback(this, function(a) {
		// 	component.set("v.totalNumberOfRows", a.getReturnValue());
		// });
		// $A.enqueueAction(totalCnt);
		

		this.getRecordCount(component, event)
			.then(result => {
				console.log('MC-');
				console.log(result);
				this.getData(component, event)
					.then(result1 => {
						console.log(result1);
						this.getLabels(component, event)
							.then(result2 => {
								console.log(result2);
								this.createColumns(component, event);
							});
					});
			});
	},

	getRecordCount: function(component, event, helper) {
		return new Promise($A.getCallback(function(resolve, reject) {
			var totalCnt = component.get("c.getTotalCount");
			totalCnt.setCallback(this, response => {
				var result = response.getReturnValue();
				component.set("v.totalNumberOfRows", result);
				resolve(result);
			});
			$A.enqueueAction(totalCnt);
		}));
	},

	getLabels: function(component, event) {
		return new Promise($A.getCallback(function(resolve, reject) {
			let action = component.get('c.getLabels');
			action.setCallback(this, (response) => {
				let result = response.getReturnValue();
				component.set("v.labels", result);
				resolve(result);
			});
			$A.enqueueAction(action);
		}));

	},

	fetchData: function(component, event) {
		return new Promise($A.getCallback(function(resolve, reject) {
			let currentDatatemp = component.get('c.getBirthdays');
			let counts = component.get("v.currentCount");
			currentDatatemp.setParams({
				"limits": component.get('v.rowsToLoad'),
				"offsets": counts
			});
			currentDatatemp.setCallback(this, (response) => {

				let result = response.getReturnValue();
				if (result != null && result.length != undefined) {
					console.log('MC-');
					result.forEach(element => {
						console.log(element);
						// element.RecordTypeId = element.RecordType.Name;
						element.linkLabel = '' + element.Name;
						element.Name =window.location.origin+'/' + element.Id;
						//MC-CR#3
						element.linkLabelAssociate = '' + element.Associate__r.Name;
						element.Associate__c = window.location.origin+'/' + element.Associate__c;
					});
				}
				else if (result != null) {
					// result.RecordTypeId = result.RecordType.Name;
					result.linkLabel = result.Name;
					result.Name = window.location.origin+'/' + element.Id;
				}

				let countstemps = component.get("v.currentCount");
				countstemps = countstemps + component.get('v.rowsToLoad');
				component.set("v.currentCount", countstemps);
				// component.set('v.data', result);
				resolve(result);
			});
			$A.enqueueAction(currentDatatemp);


		}));

	},

	getData: function(component, event) {
		return new Promise($A.getCallback(function(resolve, reject) {
			let action = component.get("c.getBirthdays");
			action.setParams({
				"limits": component.get("v.initialRows"),
				"offsets": component.get("v.rowNumberOffset")
			});
			action.setCallback(this, (response) => {
				let result = response.getReturnValue();
				if (result != null && result.length != undefined) {
					result.forEach(element => {
						// element.RecordTypeId = element.RecordType.Name;
						element.linkLabel = '' + element.Name;
						element.Name = window.location.origin+'/' + element.Id;
						//MC-CR19#48
						if(element.PersonBirthdate != null && element.PersonBirthdate != '' && element.PersonBirthdate != undefined){
							let dateBirth = new Date(element.PersonBirthdate);
							element.orderingValue = ((dateBirth.getMonth().toString().length == 1) ? '0' + dateBirth.getMonth().toString() : dateBirth.getMonth().toString()) + (((dateBirth.getDate() + 1).toString().length == 1) ? '0' + (dateBirth.getDate() + 1).toString() : (dateBirth.getDate() + 1).toString());
						}else {element.orderingValue = null}
					});
					//order the result by month
					result.sort(function(a,b){
						return a.orderingValue < b.orderingValue ? -1 : 1;
					});

					/*result.forEach(function(elem){
						console.log("MC-Ordered Result: " + elem.orderingValue);
					}); */
				}
				else if (result != null) {
					// result.RecordTypeId = result.RecordType.Name;
					result.linkLabel = result.Name;
					result.Name = window.location.origin+'/' + element.Id;
				}
				component.set("v.data", result);
				component.set("v.currentCount", component.get("v.initialRows"));
				resolve(result);

			});
			$A.enqueueAction(action);
		}))
	},

	createColumns: function(component, event) {
		return new Promise($A.getCallback(function(resolve, reject) {
			let labels = component.get('v.labels');



			if (labels != undefined && labels != null) {
				component.set('v.columns', [

					// {
					// 	label: (labels['name'] != undefined && labels['name'] != null && labels['name'] != '') ? labels['name'] : 'Name', fieldName: 'Name', type: 'url', sortable: false, typeAttributes: {
					// 		label: { fieldName: 'linkLabel' }
					// 	}
					// },
					// //MC-CR#3 --> PersonBirthdate and Profiling
					// { label: (labels['PersonBirthdate'] != undefined && labels['PersonBirthdate'] != null && labels['PersonBirthdate'] != '') ? labels['PersonBirthdate'] : 'Birthdate', fieldName: 'PersonBirthdate',type: 'date',sortable: false},
					// { label: (labels['marketing_y_n__c'] != undefined && labels['marketing_y_n__c'] != null && labels['marketing_y_n__c'] != '') ? labels['marketing_y_n__c'] : 'Marketing Y N', fieldName: 'Marketing_Y_N__c', type: 'boolean', sortable: false },
					// { label: (labels['Privacy3__c'] != undefined && labels['Privacy3__c'] != null && labels['Privacy3__c'] != '') ? labels['Privacy3__c'] : 'Profiling', fieldName: 'Privacy3__c',type: 'boolean',sortable: false},
					// { label: (labels['email__c'] != undefined && labels['email__c'] != null && labels['email__c'] != '') ? labels['email__c']: 'Email', fieldName: 'Email__c', type: 'boolean', sortable: false },
					// { label: (labels['posta__c'] != undefined && labels['posta__c'] != null && labels['posta__c'] != '') ? labels['posta__c'] : 'Mail', fieldName: 'Posta__c', type: 'boolean', sortable: false },
					// { label: (labels['telefono__c'] != undefined && labels['telefono__c'] != null && labels['telefono__c'] != '') ? labels['telefono__c'] : 'Telefono', fieldName: 'Telefono__c', type: 'boolean', sortable: false },
					{
						label: (labels['name'] != undefined && labels['name'] != null && labels['name'] != '') ? labels['name'] : 'Name', fieldName: 'Name', type: 'url', sortable: false, typeAttributes: {
							label: { fieldName: 'linkLabel' }
						}
					},
					{ label: (labels['PersonBirthdate'] != undefined && labels['PersonBirthdate'] != null && labels['PersonBirthdate'] != '') ? labels['PersonBirthdate'] : 'Birthdate', fieldName: 'PersonBirthdate',type: 'date',sortable: false},
					{ label: 'Marketing', fieldName: 'Presenza_Marketing__c', type: 'boolean', sortable: false },
					{ label: (labels['Privacy3__c'] != undefined && labels['Privacy3__c'] != null && labels['Privacy3__c'] != '') ? labels['Privacy3__c'] : 'Profiling', fieldName: 'Privacy3__c',type: 'boolean',sortable: false},
					{ label: (labels['email__c'] != undefined && labels['email__c'] != null && labels['email__c'] != '') ? labels['email__c']: 'E-mail', fieldName: 'Presenza_Email__c', type: 'boolean', sortable: false },
					{ label: (labels['Street_Label__c'] != undefined && labels['Street_Label__c'] != null && labels['Street_Label__c'] != '') ? labels['Street_Label__c']: 'Mail', fieldName: 'Presenza_Address__c', type: 'boolean', sortable: false },
					{ label: (labels['Checkbox_Phone_Label__c'] != undefined && labels['Checkbox_Phone_Label__c'] != null && labels['Checkbox_Phone_Label__c'] != '') ? labels['Checkbox_Phone_Label__c']: 'Phone', fieldName: 'Presenza_Phone__c', type: 'boolean', sortable: false },
					{ label: (labels['We_Chat_ID_Label__c'] != undefined && labels['We_Chat_ID_Label__c'] != null && labels['We_Chat_ID_Label__c'] != '') ? labels['We_Chat_ID_Label__c']: 'WeChat', fieldName: 'Presenza_WeChat__c', type: 'boolean', sortable: false }
				]);
				resolve(component.get('v.columns'));

			}
		}));
	}
})