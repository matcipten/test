({
    searchHelper: function(component, event, getInputkeyWord) {
        // call the apex class method 
        var action = component.get("c.fetchLookUpValues");
        // set param to method  
        action.setParams({
            'searchKeyWord': getInputkeyWord,
            'ObjectName': component.get("v.objectAPIName"),
            'searchObjectKey': component.get("v.searchObjectKey"),
            'searchObjectValue': component.get("v.searchObjectValue"),
            'filter': component.get("v.filter"),
            'idLocMicros':component.get("v.idLocMicros")
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    //var noResultFoundLabel = LABEEEL
                    var noResultFoundLabel = 'No results found';
                    var messageToShow = noResultFoundLabel + '...';
                    component.set("v.Message", messageToShow);
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);

                if (component.get("v.listOfSearchRecords") != undefined && component.get("v.listOfSearchRecords") != null
                    && $A.util.isArray(component.get("v.listOfSearchRecords")) && component.get("v.listOfSearchRecords").length == 1) {
                    var compEvent = component.getEvent("oSelectedRecordEvent");
                    compEvent.setParams({ "recordByEvent": component.get("v.listOfSearchRecords")[0] });
                    compEvent.fire();
                    //                	this.onblur(component,event);
                }

            }

        });
        // enqueue the Action  
        $A.enqueueAction(action);

    },

    forceInitValue: function(component, event) {
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");

        var params = event.getParam('arguments');
        if (params) {
            var param1 = params.selected;
            // add your code here
        }

        component.set("v.selectedRecord", param1);
        console.log('param1');
        console.log(param1);
        if (param1 != undefined && param1 != null){
            component.set("v.selectedRecord", param1);
            component.set("v.value" , param1.Id);
        }            
                
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');

        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
            
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(lookUpTarget, 'slds-hide');
        $A.util.removeClass(lookUpTarget, 'slds-show');

        var searchIcon = component.find("searchIcon");   
        $A.util.removeClass(searchIcon, 'slds-show');     
        $A.util.addClass(searchIcon, 'slds-hide');

        component.set("v.forced",true);

    },

    onblur: function(component, event) {
        component.set("v.listOfSearchRecords", null);
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
})