({
    afterScriptsLoaded : function(component, event, helper) {
        component.set("v.ready", true);
        helper.createChart(component);
    },
    handleClick : function(component, event, helper) {
        var reportId = component.get("v.reportId");
        // Uses the pageReference definition in the init handler
        var urlEvent = $A.get('e.force:navigateToURL');
        urlEvent.setParams({
            "url": '/lightning/r/Report/'+reportId+'/view?queryScope=userFolders&fv0='+component.get("v.recordId")
        });
        urlEvent.fire();
        
    }
})