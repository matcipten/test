({
    getAttachments : function(component) {
        var action = component.get("c.getAttachments");
        action.setParams({
            parentId : component.get("v.recordId")
        });
        
        action.setCallback(this, function(a) {
            if (a.getState() === "SUCCESS") {
                var attachments = a.getReturnValue();
                console.log(attachments);
                component.set("v.attachments", attachments);
                if(attachments.length > 20){
                    component.set("v.max_value", 20);
                }else{
                    component.set("v.max_value", attachments.length);
                }
                var checkMax_value =component.get("v.max_value");
                if(checkMax_value <= 4){
                    component.set("v.isButtonShownleft", false);
                    component.set("v.isButtonShownRight", false);
                }else{
                    component.set("v.isButtonShownleft", true);
                    component.set("v.isButtonShownRight", true);
        }
            } else if (a.getState() === "ERROR") {
                console.log("oof");
            }
        });
        $A.enqueueAction(action);
    }
})