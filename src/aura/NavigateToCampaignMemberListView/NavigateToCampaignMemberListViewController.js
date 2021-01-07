({
    doInit : function(component, event, helper) {
        console.log('recordId ' + component.get("v.recordId"));
        //verify user
        var action = component.get("c.verifyUser");
        action.setParams({
            
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var result  =  response.getReturnValue();
                //if result is true would redirect to standard list view of campaign member or else creates a custom component
                
                
                var navService = component.find("navService");
                if(result){
                    var pageReference = {    
                        "type": "standard__recordRelationshipPage",
                        "attributes": {
                            "recordId": component.get("v.recordId"),
                            "relationshipApiName": "CampaignMembers",
                            "actionName": "view"
                        }
                    };
                    console.log(pageReference);
                    navService.navigate(pageReference);   
                }else{
                    var pageReference = {
                        type: 'standard__component',
                        attributes: {
                            componentName: 'c__CampaignMemberListView',
                        },
                        state: {
                            "c__recordId": component.get("v.recordId")
                        }
                    };
                    component.set("v.pageReference", pageReference);
                    navService.navigate(pageReference);
                }
                
                
                
            }else if(state === "ERROR"){
                alert('in error');
            }
        });
        $A.enqueueAction(action);
        
       
    }
})