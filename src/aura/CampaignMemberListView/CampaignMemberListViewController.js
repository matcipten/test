({

    doInit: function(component, event, helper) {
        var actions = [
            { label: 'Edit', name: 'Edit' },
            { label: 'Delete', name: 'delete' }
        ];
        /*component.set('v.columns', [
            {
                label: 'Type', fieldName: 'linkType', type: 'url',
                typeAttributes: { label: { fieldName: 'Type' }, target: '_blank' }
            },
            { label: 'Status', fieldName: 'Status', type: 'text' },
            {
                label: 'FirstName', fieldName: 'linkFirstName', type: 'url',
                typeAttributes: { label: { fieldName: 'FirstName' }, target: '_blank' }
            },
            {
                label: 'LastName', fieldName: 'linkLastName', type: 'url',
                typeAttributes: { label: { fieldName: 'LastName' }, target: '_blank' }
            },
            { label: 'Title', fieldName: 'Title', type: 'text' },
            { label: 'Company', fieldName: 'CompanyOrAccount', type: 'text' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);*/
        component.set('v.columns', [
            {label: 'Account Name', fieldName: 'Contact_Account_Name', type: 'text'},
            {label: 'Status', fieldName: 'Status', type: 'text' },
            {label: 'Account Profiling', fieldName: 'Contact_Account_Profiling', type: 'boolean' },
            {label: 'Account Marketing', fieldName: 'Contact_Account_Marketing', type: 'boolean' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);


        helper.getCampaignMembers(component, helper);

    },


    filterCampaignMembers: function(component, event, helper) {
        console.log('Akshay');
        var searchValue = component.get("v.searchText");
		if (searchValue != '' && searchValue != null)
        	helper.filterCampaignMembersHelper(component, helper, searchValue);
    },
    filterContacts: function(component, event, helper) {
        var searchValue = component.get("v.searchContact");
        component.set("v.itemsPill", component.get("v.items"));
        console.log(searchValue);
        helper.filterContactsHelper(component, searchValue);

    },
    addContactsWhenSelected: function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows');

        console.log(selectedRows);
        let obj = [];
        var idContactsMap = [];
        var alreadyselectedObj = component.get("v.itemsPill");
        console.log(alreadyselectedObj);
        for (var i = 0; i < selectedRows.length; i++) {
            console.log(!alreadyselectedObj.hasOwnProperty(selectedRows[i].Id));
            if (!alreadyselectedObj.hasOwnProperty(selectedRows[i].Id)) {
                obj.push({
                    type: 'avatar',
                    href: '',
                    label: selectedRows[i].Name,
                    Id: selectedRows[i].Id,
                    Name: selectedRows[i].Name,
                    src: '/docs/component-library/app/images/examples/avatar2.jpg',
                    fallbackIconName: 'standard:contact',
                    variant: 'circle',
                    alternativeText: 'User avatar',
                });

            }
            idContactsMap.push(selectedRows[i].Id);

        }
        console.log(obj);

        var newData = alreadyselectedObj.concat(obj);
        var newDataMap = new Map();
        for (var i = 0; i < newData.length; i++) {
            newDataMap.set(newData[i].Id, newData[i]);
        }
        console.log(newDataMap.values());
        component.set("v.items", newData);
        console.log(component.get("v.items"));
        component.set("v.idContacts", idContactsMap);
        //component.set("v.itemsPill", component.get("v.items"));
        console.log(idContactsMap);
        console.log(JSON.stringify(idContactsMap));
        // console.log(obj.length);

        // if (component.get('v.searchContact') != undefined && component.get('v.searchContact') != null)
        //     helper.filterContactsHelper(component, component.get('v.searchContact'));
        // else
        //     helper.filterContactsHelper(component, '');

    },
    addCampaignMemWhenSelected: function(component, event, helper) {
        console.log('Akshay');
        var selectedRows = event.getParam('selectedRows');
        console.log(selectedRows);

        let obj = [];
        for (var i = 0; i < selectedRows.length; i++) {

            obj.push({
                Id: selectedRows[i].Id,
                Status: selectedRows[i].Status,
                Type: selectedRows[i].Type,
                FirstName: selectedRows[i].FirstName,
                LastName: selectedRows[i].LastName,
                Contact_Account_Name: selectedRows[i].Contact.Account.Name
            });
        }

        component.set("v.selectedRows", selectedRows);
        console.log(obj);
        console.log(JSON.stringify(obj));
        // console.log(obj.length);

    },

    addContactAsCampaignMem: function(component, event, helper) {
        helper.showSpinner(component);
        component.set("v.showAddContact", true);
        component.set("v.showCampaignMembers", false);
        component.set('v.columnsContacts', [
            { label: 'Name', fieldName: 'Name', type: 'text' },
            { label: 'CustomerName', fieldName: 'accountName', type: 'text' },
            { label: 'Phone', fieldName: 'Phone', type: 'text' },
            { label: 'Email', fieldName: 'Email', type: 'text' },
            { label: 'Contact Owner Alias', fieldName: 'Owner.Name', type: 'text' },

        ]);
        helper.getContactsFromApex(component, event, helper);

    },
    closeModal: function(component, event, helper) {
        var vuoto = [];
        component.set("v.items", vuoto);
        component.set("v.showAddContact", false);
        component.set("v.showCampaignMembers", true);
        console.log('Akshay');

    },
    deleteCampaignMem: function(component, event, helper) {
        var selectedPosters = component.get("v.selectedRows");
        var IDs = [];
        var obj = component.get("v.data");
        for (var i = 0; i < selectedPosters.length; i++) {
            IDs[i] = selectedPosters[i].Id;
            let indexValue = obj.indexOf(selectedPosters[i]);
            console.log(indexValue);
            obj.splice(indexValue, 1);
        }

        var action = component.get("c.deleteCampaignMembers");
        action.setParams({
            'campMemIds': IDs
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var result = response.getReturnValue();
            if (state === "SUCCESS") {

                component.set("v.data", obj);

            } else if (state === "ERROR") {

            } else {

            }


        });
        $A.enqueueAction(action);
        //helper.campaignMembersToBeDeleted(component, selectedPosters,  null);

    },

    handleItemRemove: function(component, event) {
        var name = event.getParam("item").Id;
        
        // Remove the pill from view
        var items = component.get('v.items');
        var item = event.getParam("index");
        items.splice(item, 1);
        let itemToRemove = items[item];

        var itemsPill = component.get('v.itemsPill');
        //console.log(itemsPill.findIndex(name));
        var itemPill = event.getParam("index");
        
        itemsPill.splice(itemPill,1);
        
        component.set('v.items', items);

        let myTableRows = component.find('contactDataTable').getSelectedRows();
        let myIdsList = [];
        for(let i = 0 ; i < myTableRows.length; i++){
            if(myTableRows[i].Id != itemToRemove.Id){
                myIdsList.push(myTableRows[i].Id);
            }
            
        }

        component.find('contactDataTable').set('v.selectedRows',myIdsList);
        

    },
    handleRowAction: function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');

        switch (action.name) {
            case 'Edit':
                component.set("v.CampaignMemberId", row.Id);
                component.set("v.editCampaignMember", true);
                // helper.editCampaignMember(component,event);
                break;
            case 'delete':
                // var rows = component.get('v.mydata');
                var IDs = [];
                var obj = component.get("v.data");
                IDs.push(row.Id);
                let indexValue = obj.indexOf(row);
                console.log(row);
                obj.splice(indexValue, 1);
                var action = component.get("c.deleteCampaignMembers");
                action.setParams({
                    'campMemIds': IDs
                });
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    var result = response.getReturnValue();
                    if (state === "SUCCESS") {

                        component.set("v.data", obj);

                    } else if (state === "ERROR") {

                    } else {

                    }


                });
                $A.enqueueAction(action);
                //helper.campaignMembersToBeDeleted(component, null , row);  

                break;
        }
    },
    handleRowActionCont: function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');

        switch (action.name) {
            case 'show_details':
                break;
            case 'delete':
                var rows = component.get('v.mydata');
                var rowIndex = rows.indexOf(row);
                rows.splice(rowIndex, 1);
                component.set('v.mydata', rows);
                break;
        }
    },
    fireBeforeSavingCampaign: function(component, event, helper) {
        var obj = component.get("v.idContacts");
        if (obj.length == 0) {
            helper.showToast({
                "title": "Error",
                "type": "error",
                "message": "Please Select atleast one Customer"
            });
            return;
        }
        component.set("v.BeforeSavingCampaign", false);
        helper.fetchPickListVal(component, 'status', 'InputSelectDynamic', component.get("v.campaignMemRecord"));



    },
    fireWhileSavingCampaign: function(component, event, helper) {

        var items = component.get("v.items");
        var obj = [];
        if (items != null) {
            for (var i = 0; i < items.length; i++) {
                obj.push(items[i].Id);
            }
        }

        if (obj.length == 0) {
            helper.showToast({
                "title": "Error",
                "type": "error",
                "message": "Please Select atleast one Customer"
            });
            return;
        }
        component.set("v.showAddContact", false);
        helper.showSpinner(component);
        var action = component.get("c.insertContactsAsCampaignMem");

        action.setParams({
            'contactId': obj,
            'Status': component.get("v.campaignMemRecord.status"),
            'camp': component.get("v.recordId"),
            'modifyStatus': component.get("v.checkBoxValue")

        });
        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                component.set("v.NodataFound", false);
                var result = response.getReturnValue();
                console.log(result);
                if (result != null) {
                    result.forEach(function(item) {
                        item.linkFirstName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        item.linkLastName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        item.linkType = '/lightning/r/CampaignMember/' + item.ContactId + '/view';
                    });
                    component.set("v.data", result);
                    $A.get("e.force:refreshView").fire();
                    helper.showToast({
                        "title": "Record Inserted",
                        "type": "success",
                        "message": " Camapign Members Created"
                    });
                }


                helper.hideSpinner(component);

            }
            else if (state === "ERROR") {

                let errors = response.getError();
                let message = 'Unknown error'; // Default error message
                // Retrieve the error message sent by the server
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                // Display the message
                console.error(message);
                helper.showToast({
                    "title": "Error",
                    "type": "error",
                    "message": message
                });
            }

        });
        $A.enqueueAction(action);



    },
    handleOnSuccess: function(component, event, helper) {
        component.set("v.editCampaignMember", false);
        var record = event.getParam("response");
        component.find("notificationsLibrary").showToast({
            "title": "Saved",
            "message": "{0} saved for {1}",
            "messageData": [
                {
                    url: '/' + record.id,
                    label: record.fields.ContactId.value
                }

            ]
        });
    },
    handleOnError: function(component, event, helper) {
        //component.set("v.editCampaignMember", false);
        var record = event.getParam("response");
        component.find("notificationsLibrary").showToast({
            "variant": "error",
            "header": "Something has gone wrong!",
            "message": "Unfortunately, there was a problem updating the record.",
            "messageData": [
                {
                    url: '/' + record.id,
                    label: record.fields.ContactId.value
                }

            ]
        });
    },
    handleOnSubmit: function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam("fields");
        //fields["AccountId"] = component.get("v.parentId");
        component.find("form").submit(fields);
    },
    closeModalEditCM: function(component, event, helper) {
        component.set("v.editCampaignMember", false);
    },

    refreshCmp: function(component, event, helper) {
        $A.get("e.force:refreshView").fire();
    },
    onLoadMoreData: function(component, event, helper) {
        if (component.get("v.totalCampaignMems") == component.get("v.data").length) {
            return;
        }
        helper.showSpinner(component);
        var rowsToLoad = component.get('v.rowsToLoad'),
            fetchData = component.get('v.data'),
            promiseData;
        console.log(component.get('v.rowsToLoad'));

        console.log(rowsToLoad);

        //component.set('v.loadMoreStatus', 'Loading');
        var action = component.get("c.getCampaignMembers");
        action.setParams({
            'campaignId': component.get("v.recordId"),
            'offset': fetchData.length
        });
        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log(result);
                if (result != null) {
                    result.forEach(function(item) {
                        item.linkFirstName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        item.linkLastName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        item.linkType = '/lightning/r/CampaignMember/' + item.ContactId + '/view';
                    if (item.Contact.Account.Name != null) item.Contact_Account_Name = item.Contact.Account.Name;
                    if (item.Contact.Account.Name != null) item.Contact_Account_Profiling = item.Contact.Account.Privacy3__c;
                    if (item.Contact.Account.Name != null) item.Contact_Account_Marketing = (item.Contact.Account.Privacy1__c || item.Contact.Account.Privacy2__c);
                    });

                    var currentData = component.get('v.data');
                    var newData = currentData.concat(result);
                    component.set('v.data', newData);
                    //component.set("v.data", result);    
                    if (component.get("v.totalCampaignMems") > component.get("v.data").length) {
                        component.set("v.showLoadCM", true);

                    } else {
                        component.set("v.showLoadCM", false);
                    }


                } else {
                    component.set("v.NodataFound", true);
                    component.set("v.showLoadCM", false);
                    event.getSource().set("v.isLoading", false);
                }

            } else if (state === "ERROR") {
            }
        });
        $A.enqueueAction(action);
        helper.hideSpinner(component);

    },
    onLoadAllData: function(component, event, helper) {
        if (component.get("v.totalCampaignMems") == component.get("v.data").length) {
            return;
        }
        helper.showSpinner(component);
        var action = component.get("c.getAllCampaignMembers");

        action.setParams({
            'campaignId': component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log(result);

                if (result != null) {

                    result.forEach(function(item) {
                        item.linkFirstName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        item.linkLastName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        item.linkType = '/lightning/r/CampaignMember/' + item.ContactId + '/view';
                    if (item.Contact.Account.Name != null) item.Contact_Account_Name = item.Contact.Account.Name;
                    if (item.Contact.Account.Name != null) item.Contact_Account_Profiling = item.Contact.Account.Privacy3__c;
                    if (item.Contact.Account.Name != null) item.Contact_Account_Marketing = (item.Contact.Account.Privacy1__c || item.Contact.Account.Privacy2__c);                          
                    });

                    component.set("v.data", result);
                    if (component.get("v.totalCampaignMems") > component.get("v.data").length) {
                        component.set("v.showLoadCM", true);

                    } else {
                        component.set("v.showLoadCM", false);
                    }

                } else {
                    component.set("v.NodataFound", true);
                    component.set("v.showLoadCM", false);

                }
                helper.hideSpinner(component);
            } else if (state === "ERROR") {

            }
        });
        $A.enqueueAction(action);


    },
    onLoadAllContacts: function(component, event, helper) {
        if (component.get("v.totalContacts") == component.get("v.dataContacts").length) {
            return;
        }
        helper.showSpinnerInside(component);
        var action = component.get("c.getAllContacts");
        action.setParams({

        });
        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                var result = response.getReturnValue();

                console.log(result);
                if (result != null) {
                    component.set("v.dataContacts", result);
                    if (component.get("v.totalContacts") > component.get("v.dataContacts").length) {
                        component.set("v.showLoadCont", true);
                    } else {
                        component.set("v.showLoadCont", false);
                    }
                } else {
                    component.set("v.NodataFoundCont", true);
                    component.set("v.showLoadCont", false);
                }
                helper.hideSpinnerInside(component);
            } else if (state === "ERROR") {

            }
        });
        $A.enqueueAction(action);


    },
    onLoadMoreContacts: function(component, event, helper) {
        if (component.get("v.totalContacts") == component.get("v.dataContacts").length) {
            return;
        }
        var fetchData = component.get("v.dataContacts");
        console.log(fetchData.length);
        helper.showSpinnerInside(component);
        var action = component.get("c.getContacts");
        action.setParams({
            'offset': fetchData.length
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();

                console.log(result);
                if (result != null) {
                    var currentData = component.get('v.dataContacts');
                    var newData = currentData.concat(result);
                    component.set('v.dataContacts', newData);
                    if (component.get("v.totalContacts") > component.get("v.dataContacts").length) {
                        component.set("v.showLoadCont", true);
                    } else {
                        component.set("v.showLoadCont", false);
                    }
                    //component.set("v.dataContacts", result);
                } else {
                    component.set("v.NodataFoundCont", true);
                    component.set("v.showLoadCont", false);

                }

            } else if (state === "ERROR") {

            }
        });
        $A.enqueueAction(action);
        helper.hideSpinnerInside(component);

    },


})