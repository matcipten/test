({
    doInit: function(component, event, helper) {  
        //component.set("v.recId",component.get("v.recordId"));
        helper.getAttachments(component);
        
    },
    
    prevButton: function(component, event, helper) {  
        //component.set("v.recId",component.get("v.recordId"));
        //console.log("PREVIEW");
        var width = document.getElementById('container').offsetWidth;
        var width_content = document.getElementById('content').offsetWidth;
        //console.log(width);
        var i = component.get("v.index");
        if (i === 0) {
            i = 0;
        } else {
            i--;
            width_content = width_content - 211;
            document.getElementById('content').style.width = width_content + 'px';
        }
        component.set("v.index", i);
        //var cmpTarget = component.find('changeIt');
        var slidesContainer = document.getElementById("content"); 
        slidesContainer.style.transform = 'translateX(' + i * 203 * (-1) + 'px)';
        
    },
    
    nextButton: function(component, event, helper) {  
        //component.set("v.recId",component.get("v.recordId"));
        //console.log("NEXT");
        var width = document.getElementById('container').offsetWidth;
        var width_content = document.getElementById('content').offsetWidth;
        //console.log(width);
        //console.log(width_content);
        var max_val = component.get("v.max_value");
        var i = component.get("v.index");
        //console.log('index : ' + i);
        var att_total = component.get("v.attachments");
        var att_visible = Math.round(width/211);
        if(att_total <= max_val){
            max_val = att_total;
        }
        console.log(att_total.length);
        console.log(att_visible);
        
        if (i === (max_val-att_visible)) {
            i = (max_val-att_visible);
        } else{
            i++;
            width_content = width_content + 210;
            document.getElementById('content').style.width = width_content + 'px';
        }
        //console.log(i);
        component.set("v.index", i);
        //var cmpTarget = component.find('changeIt');
        //console.log(cmpTarget);
        var slidesContainer = document.getElementById("content"); 
        slidesContainer.style.transform = 'translateX(' + i * 203 * (-1) + 'px)';
        
        
    },
    
    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
    
    likenClose: function(component, event, helper) {
        // Display alert message on the click on the "Like and Close" button from Model Footer 
        // and set set the "isOpen" attribute to "False for close the model Box.
        alert('thanks for like Us :)');
        component.set("v.isOpen", false);
    },

    //MC-CR19#28 CheckBox
    showGifts: function(component, event, helper) {
        console.log("MC- Dentro showGifts");
        //var checkbox = event.getSource();
        var element = component.find("viewOption");
        // var element = document.getElementById("viewOption");
        //var check = element.get("v.checked");
        var check = element.get('v.checked');
        console.log("MC- check: " + check);
        console.log("showall1: " + component.get("v.showall"));
        if(check){
            component.set("v.showall",true);
        }else{
            component.set("v.showall",false);
        }
        console.log("showall2: " + component.get("v.showall"));
    },
    
})