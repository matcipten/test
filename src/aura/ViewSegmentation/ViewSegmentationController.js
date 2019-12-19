({
    doInit : function(component, event, helper){
        console.log(component.get("v.pageReference").state.segmentation);
        var pageReference = component.get("v.pageReference");
        if(pageReference!==undefined && pageReference!==null && pageReference.state!=null)
        {
            var segmentation=pageReference.state.c__segmentation; 
            component.set("v.segmentation",segmentation);
            //Do whatever we want to do with record id
            console.log(segmentation); 
        }
    },
    reInit : function(component, event, helper) {
        $A.get('e.force:refreshView').fire();
    }
    
  
})