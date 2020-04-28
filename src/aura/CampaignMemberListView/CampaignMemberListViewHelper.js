({
    getCampaignMembersHelper: function(component, event, helper) {
        //added promise
        return new Promise($A.getCallback(function(resolve, reject) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
            var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
            var sParameterName;
            var id;
            var i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('='); //to split the key from the value.

                if (sParameterName[0] === 'Id') { //lets say you are looking for param name - firstName
                    id = sParameterName[1] === undefined ? null : sParameterName[1];
                }

            }
            let pageReference = component.get('v.pageReference');
            console.log(pageReference);
            if (pageReference != undefined && pageReference.state != undefined && pageReference.state.c__recordId != undefined) {
                component.set('v.recordId', pageReference.state.c__recordId);
                console.log(component.get('v.recordId'));
            }
            if (component.get("v.recordId") == null || component.get("v.recordId") == '') {
                component.set("v.recordId", id);
            }

            var action = component.get("c.getCampaign");
            action.setParams({
                campaignId: component.get("v.recordId")
            });
            action.setCallback(this, function(response) {
                var state = response.getState();

                if (state === "SUCCESS") {
                    var result = response.getReturnValue();
                    helper.getTotalNumberOfCampaignMems(component);
                    component.set("v.CampaignName", result.Name);
                    component.set("v.campaignRecord", result);
                    component.set("v.campaignUrl", '/lightning/r/Campaign/' + result.Id + '/view');

                    var action = component.get("c.getCampaignMembers");
                    action.setParams({
                        campaignId: component.get("v.recordId"),
                        'offset': 0
                    });
                    action.setCallback(this, function(response) {
                        var state = response.getState();

                        if (state === "SUCCESS") {
                            var result = response.getReturnValue();

                            console.log(result);
                            if (result != null) {
                                component.set("v.CampaignName", result[0].Campaign.Name);
                                console.log(result);
                                result.forEach(function(item) {
                                    if (item.FirstName != null) item.linkFirstName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                                    if (item.LastName != null) item.linkLastName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                                    if (item.Contact.Account.Name != null) item.Contact_Account_Name = item.Contact.Account.Name;
                                    if (item.Contact.Account.Name != null) item.Contact_Account_Profiling = item.Contact.Account.Privacy3__c;
                                    if (item.Contact.Account.Name != null) item.Contact_Account_Marketing = (item.Contact.Account.Privacy1__c || item.Contact.Account.Privacy2__c);
                                    if (item.Contact.Account.Associate__c != null) item.Account_Allocated_Client_Advisor = item.Contact.Account.Associate__r.Name
                                    if (item.Contact.Account.Data_Ultimo_Acquisto__c != null) item.Account_Last_Purchase_Date = item.Contact.Account.Data_Ultimo_Acquisto__c;
                                    if (item.Contact.Account.Importo_Acquisti_Totale__c != null) item.Account_Total_Purchase_Amount = item.Contact.Account.Importo_Acquisti_Totale__c;
                                    if (item.Contact.Account.Marketing_FRM__c != null) item.Account_Marketing = item.Contact.Account.Marketing_FRM__c;
                                    
                                    item.linkType = '/lightning/r/CampaignMember/' + item.ContactId + '/view';
                                });

                                component.set("v.data", result);
                                console.log(component.get("v.totalCampaignMems"));
                                console.log(component.get("v.data").length);
                                if (component.get("v.totalCampaignMems") > component.get("v.data").length) {
                                    component.set("v.showLoadCM", true);

                                }

                            } else {
                                component.set("v.NodataFound", true);
                                component.set("v.showLoadCM", false);
                            }
                            resolve();

                        } else if (state === "ERROR") {
                            reject();
                        }
                    });
                    $A.enqueueAction(action);

                } else if (state === "ERROR") {
                    alert('in error');
                    reject();
                }
            });
            $A.enqueueAction(action);

        }));


    },


    getContactsFromApex: function(component, event, helper) {
        this.getTotalNumberOfContacts(component);
        component.set("v.BeforeSavingCampaign", true);
        var action = component.get("c.getContacts");
        action.setParams({
            'offset': 0
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var result = response.getReturnValue();
            if (state === "SUCCESS") {
                if (result != null) {
                    console.log(result.length);
                    component.set("v.dataContacts", response.getReturnValue());
                    if (component.get("v.totalContacts") > component.get("v.dataContacts").length) {
                        component.set("v.showLoadCont", true);
                    } else {
                        component.set("v.showLoadCont", false);
                    }

                } else {
                    component.set("v.NodataFoundCont", true);
                    component.set("v.showLoadCont", false);
                }
            } else if (state === "ERROR") {
                alert('in error');
            }
            helper.hideSpinner(component);
        });
        $A.enqueueAction(action);
        helper.hideSpinner(component);
    },
    fetchPickListVal: function(component, fieldName, elementId, objType) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": objType,
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();

                opts.push({
                    class: "optionClass",
                    label: "",
                    value: ""
                });

                for (var k in allValues) {
                    opts.push({
                        class: "optionClass",
                        label: k,
                        value: allValues[k]
                    });
                }

                component.find(elementId).set("v.options", opts);
            } else if (state === "ERROR") {
                alert('in error');
            }
        });
        $A.enqueueAction(action);
    },

    /*
     * Show toast with provided params
     * */
    showToast: function(params) {
        var toastEvent = $A.get("e.force:showToast");
        if (toastEvent) {
            toastEvent.setParams(params);
            toastEvent.fire();
        } else {
            alert(params.message);
        }
    },


    filterCampaignMembersHelper: function(component, helper, searchValue) {
        var action = component.get("c.searchCamapaignMembers");
        action.setParams({
            'campaignId': component.get("v.recordId"),
            'searchText': searchValue

        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var result = response.getReturnValue();
            if (state === "SUCCESS") {
                //component.set("v.CampaignName", result[0].Campaign.Name);
                if (result != null) {
                    result.forEach(function(item) {
                        if (item.Contact.Account.Name != null) item.Contact_Account_Name = item.Contact.Account.Name;
                        if (item.Contact.Account.Name != null) item.Contact_Account_Profiling = item.Contact.Account.Privacy3__c;
                        if (item.Contact.Account.Name != null) item.Contact_Account_Marketing = (item.Contact.Account.Privacy1__c || item.Contact.Account.Privacy2__c);
                        if (item.FirstName != null) item.linkFirstName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        if (item.LastName != null) item.linkLastName = '/lightning/r/CampaignMember/' + item.Id + '/view';
                        if (item.Contact.Account.Associate__c != null) item.Account_Allocated_Client_Advisor = item.Contact.Account.Associate__r.Name
                        if (item.Contact.Account.Data_Ultimo_Acquisto__c != null) item.Account_Last_Purchase_Date = item.Contact.Account.Data_Ultimo_Acquisto__c;
                        if (item.Contact.Account.Importo_Acquisti_Totale__c != null) item.Account_Total_Purchase_Amount = item.Contact.Account.Importo_Acquisti_Totale__c;
                        if (item.Contact.Account.Marketing_FRM__c != null) item.Account_Marketing = item.Contact.Account.Marketing_FRM__c;
                       
                        item.linkType = '/lightning/r/CampaignMember/' + item.ContactId + '/view';
                    });
                    component.set("v.data", result);
                }


                if (searchValue == '' || searchValue == null) {

                    if (component.get("v.totalCampaignMems") > component.get("v.data").length) {
                        component.set("v.showLoadCM", true);
                    } else {
                        component.set("v.showLoadCM", false);
                    }
                }


            } else if (state === "ERROR") {
                alert('in error');
            }
        });
        $A.enqueueAction(action);
    },
    filterContactsHelper: function(component, searchValue) {

        let pills = component.get('v.items');
        let idsSelected = [];
        if (pills != undefined && pills != null && pills.length > 0) {
            for (let i = 0; i < pills.length; i++) {
                idsSelected.push(pills[i].Id);
            }
        }

        var action = component.get("c.searchContact");
        action.setParams({
            'contactsSelected': idsSelected,
            'searchText': searchValue
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('aksh : ' + state);
            var result = response.getReturnValue();
            if (state === "SUCCESS") {
                component.set("v.dataContacts", response.getReturnValue());
                if (searchValue == '' || searchValue == null) {

                    if (result != null && (component.get("v.totalContacts") > component.get("v.dataContacts").length)) {
                        component.set("v.showLoadCont", true);
                    } else {
                        component.set("v.showLoadCont", false);
                    }
                }
            } else if (state === "ERROR") {
                alert('in error');
            }
        });
        $A.enqueueAction(action);
    },
    campaignMembersToBeDeleted: function(component, event, rows, row) {
        var IDs = [];
        var test = [];
        var obj = component.get("v.data");

        if (rows != null) {

            for (var i = 0; i < test.length; i++) {
                IDs[i] = test[i];
                console.log(test[i]);
                let indexValue = obj.indexOf(test[i]);
                console.log(indexValue);
                obj.splice(indexValue, 1);
            }
        }
        if (row != null) {
            IDs.push(row.Id);
            let indexValue = obj.indexOf(row);
            console.log(row);
            obj.splice(indexValue, 1);
        }

        console.log('IDs');
        console.log(IDs);

        //var obj = component.get("v.data");
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
    },
    editCampaignMember: function(component, event) {

    },

    getTotalNumberOfCampaignMems: function(component) {
        var action = component.get("c.getTotalNumberOfCampaignMems");
        action.setParams({
            campaignId: component.get("v.recordId"),
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();
                component.set("v.totalCampaignMems", resultData);
                console.log(component.get("v.totalCampaignMems"));
            }
        });
        $A.enqueueAction(action);
    },
    getTotalNumberOfContacts: function(component) {
        var action = component.get("c.getTotalNumberOfContacts");
        action.setParams({
            campaignId: component.get("v.recordId"),
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var resultData = response.getReturnValue();
                component.set("v.totalContacts", resultData);
                console.log(component.get("v.totalContacts"));
            }
        });
        $A.enqueueAction(action);
    },

    showSpinner: function(component) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },

    hideSpinner: function(component) {
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    },
    showSpinnerInside: function(component) {
        var spinner = component.find("mySpinnerInside");
        $A.util.removeClass(spinner, "slds-hide");
    },

    hideSpinnerInside: function(component) {
        var spinner = component.find("mySpinnerInside");
        $A.util.addClass(spinner, "slds-hide");
    },

    //PN 20191205
    getUserInfo: function(component, event, helper) {
        return new Promise($A.getCallback(function(resolve, reject) {
            let getUserInfoAction = component.get('c.getUserInfo');
            getUserInfoAction.setCallback(this, function(response) {
                var state = response.getState();

                if (state === "SUCCESS") {
                    let myUser = response.getReturnValue();
                    component.set('v.myUser', myUser);
                    resolve(myUser);
                }
                else {
                    reject();
                }
            });
            $A.enqueueAction(getUserInfoAction);
        }));
    }

})