({
	doInit : function(component, event, helper) {
        
        var today = new Date();
        component.set('v.myDateTime', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
        helper.fetchPickListVal(component, 'Salutation', 'InputSelectDynamicTitolo');
        helper.fetchPickListVal(component, 'Sesso__c', 'InputSelectDynamicGenere');
        helper.fetchPickListVal(component, 'Nazionalita__c', 'InputSelectDynamicNationality');
        helper.fetchPickListVal(component, 'Lingua__c', 'InputSelectDynamicLang');
        helper.fetchPickListCountryVal(component, 'PersonMailingCountry', 'InputSelectDynamicCountry');

        helper.setTranslation(component);
        helper.getUserInfo(component);

        // the function that reads the url parameters
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
        console.log('Param ID: '+ id);
        if(id != null){
            helper.getAccountFields(component, id);
        }

	},
    
    doneRendering: function(cmp, event, helper) {
        var signaturePad;
        var canvas = cmp.find("canvas").getElement();
        var width = document.getElementById("container").offsetWidth;
        helper.resizeCanvas(canvas, width);
        signaturePad = new SignaturePad(canvas);
        cmp.set("v.sPad64", '');        
    },
    
    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        document.getElementsByTagName('html')[0].setAttribute('lang',event.getSource().get("v.value")); 
        var evntsource = event.getSource();
        var picklistValue = evntsource.get("v.value");
        component.set('v.language', picklistValue);
        helper.setTranslationInPicklist(component);
    },
    
    sPadClear: function(cmp, event, helper){
        var signaturePad;
    	var canvas = cmp.find("canvas").getElement();
        var width = document.getElementById("container").offsetWidth;
        helper.resizeCanvas(canvas, width);
        signaturePad = new SignaturePad(canvas);
        cmp.set("v.sPad64", '');
	},
    
    validateAndRegistration: function(cmp, event, helper){
        
        cmp.set("v.buttonDisable",true);
        
        var sign = cmp.find("canvas").getElement();
        var is_canvas_blank = helper.isCanvasTransparent(sign);
        console.log('is canvas transparent: ' + is_canvas_blank);

        if(is_canvas_blank){
            cmp.set("v.sPad64", '');
        } else {
            cmp.set("v.sPad64", sign.toDataURL());
        }
        
        // location__c --> Select id from Location__c where id_location__c =: User.Codice_Boutique__c
        // Id_location__c --> User.Codice_Boutique__c
        var locale = cmp.get("v.locale");
        console.log('locale: ' + locale);
        var item = cmp.get("v.newItem");
        console.log('item: ' + item);
        var errors = [];
        var validitem = true;

        var cmpTarget = cmp.find('errors-container');
        $A.util.removeClass(cmpTarget, 'uiInputDefaultError');

        if(locale == 'JP'){
            var nameField = cmp.find("itemNameJP");
            if(item.FirstName == null || item.FirstName == ''){
                validitem = false;
                nameField.set("v.errors", [{message:""}]);
                errors.push('Please enter First Name');
            } else {
                nameField.set("v.errors",null);
            }
            
            var surnameField = cmp.find("itemSurnameJP");
            if(item.LastName == null || item.LastName == ''){
                validitem = false;
                surnameField.set("v.errors", [{message:""}]);
                errors.push('Please enter Last Name');
            } else {
                surnameField.set("v.errors",null);
            }
        } else {
            var nameField = cmp.find("itemName");
            if(item.FirstName == null || item.FirstName == ''){
                validitem = false;
                nameField.set("v.errors", [{message:""}]);
                errors.push('Please enter First Name');
            } else {
                nameField.set("v.errors",null);
            }
            
            var surnameField = cmp.find("itemSurname");
            if(item.LastName == null || item.LastName == ''){
                validitem = false;
                surnameField.set("v.errors", [{message:""}]);
                errors.push('Please enter Last Name');
            } else {
                surnameField.set("v.errors",null);
            }
        }

        var canvas = cmp.find("canvas");
        var signField_value = cmp.get("v.sPad64");
        console.log('signField_value: ' + signField_value);
        if (!signField_value || signField_value == ''){
            validitem = false;
            $A.util.addClass(canvas, 'changeMe');
            errors.push('Remember to Sign and Save');
        }
        else {
            $A.util.removeClass(canvas, 'changeMe');
        }

        var phoneField  = cmp.find("itemPhone");
        var mobileField = cmp.find("itemPersonMobilePhone");
        if(item.Telefono__c){
            if((item.Phone == null || item.Phone == '') && (item.PersonMobilePhone == null || item.PersonMobilePhone == '')){
                validitem = false;
                phoneField.set("v.errors", [{message:"phone"}]);
                mobileField.set("v.errors", [{message:"mobile"}]);
                errors.push('If you want to be contacted by phone, enter a phone');
            } else {
                phoneField.set("v.errors", null);
                mobileField.set("v.errors", null);
            }
        } else {
            phoneField.set("v.errors", null);
            mobileField.set("v.errors", null);
        }

        var emailField  = cmp.find("itemPersonEmail");
        if(item.Email__c){
            if(item.PersonEmail == null || item.PersonEmail == ''){
                validitem = false;
                emailField.set("v.errors", [{message:""}]);
                errors.push('If you want to be contacted by email, enter an email');
            } else {
                emailField.set("v.errors", null);
            }          
        } else {
            emailField.set("v.errors", null);
        }
        
        var DateBirthField = document.getElementById("date-input-id-div");
        var x = new Date(Date.now());
        var y = new Date(item.PersonBirthdate);
        var diff =(x - y) / 1000;
        diff /= (60 * 60 * 24);
        
        if(Math.abs(Math.round(diff/365.25)) < 16){
            validitem = false;
            $A.util.addClass(DateBirthField, 'changeMe');
            errors.push('Data from customers under the age of 16 can not be collected and recorded in our systems.');
        } else {
            emailField.set("v.errors", null);
        }
        
        if(locale == 'CN'){
            var wechatField  = cmp.find("itemWechatId");
            if(item.WeChat__c){
                if(item.We_Chat_ID__c == null || item.We_Chat_ID__c == ''){
                    validitem = false;
                    wechatField.set("v.errors", [{message:""}]);
                    errors.push('If you want to be contacted by wechat, enter an wechat ID');
                } else {
                    wechatField.set("v.errors", null);
                }          
            } else {
                wechatField.set("v.errors", null);
            }
        }

        var streetField      = cmp.find("itemPersonMailingStreet");
        var cityField        = cmp.find("itemPersonMailingCity");
        var postalcodeField  = cmp.find("itemPersonMailingPostalCode");
        var countryField     = cmp.find("InputSelectDynamicCountry");

        if(locale == 'US'){
            var stateField  = cmp.find("itemPersonMailingState");
        }
        if(item.Posta__c){
            if(locale == 'US'){
                if((item.PersonMailingStreet == null || item.PersonMailingStreet == '') || (item.PersonMailingCity == null || item.PersonMailingCity == '') || (item.PersonMailingPostalCode == null || item.PersonMailingPostalCode == '') || (item.PersonMailingState == null || item.PersonMailingState == '') || (item.PersonMailingCountry == null || item.PersonMailingCountry == '')){
                    validitem = false;
                    errors.push('If you want to be contacted by mail, enter a mailing address');
                    if(item.PersonMailingStreet == null || item.PersonMailingStreet == ''){
                        streetField.set("v.errors", [{message:""}]);
                    } else {
                        streetField.set("v.errors", null);
                    } 
                    if(item.PersonMailingCity == null || item.PersonMailingCity == ''){
                        cityField.set("v.errors", [{message:""}]);
                    } else {
                        cityField.set("v.errors", null);
                    } 
                    if(item.PersonMailingPostalCode == null || item.PersonMailingPostalCode == ''){
                        postalcodeField.set("v.errors", [{message:""}]);
                    } else {
                        postalcodeField.set("v.errors", null);
                    } 
                    if(item.PersonMailingState == null || item.PersonMailingState == ''){
                        stateField.set("v.errors", [{message:""}]);
                    } else {
                        stateField.set("v.errors", null);
                    }
                    if(item.PersonMailingCountry == null || item.PersonMailingCountry == ''){
                        $A.util.addClass(countryField, 'changeMe');
                    }
                    else {
                        $A.util.removeClass(countryField, 'changeMe');
                    }
                } else {
                    streetField.set("v.errors", null);
                    cityField.set("v.errors", null);
                    postalcodeField.set("v.errors", null);
                    stateField.set("v.errors", null);
                    $A.util.removeClass(countryField, 'changeMe');
                }  
            } else {
                if((item.PersonMailingStreet == null || item.PersonMailingStreet == '') || (item.PersonMailingCity == null || item.PersonMailingCity == '') || (item.PersonMailingPostalCode == null || item.PersonMailingPostalCode == '') || (item.PersonMailingCountry == null || item.PersonMailingCountry == '')){
                    validitem = false;
                    errors.push('If you want to be contacted by mail, enter a mailing address');
                    if(item.PersonMailingStreet == null || item.PersonMailingStreet == ''){
                        streetField.set("v.errors", [{message:""}]);
                    } else {
                        streetField.set("v.errors", null);
                    } 
                    if(item.PersonMailingCity == null || item.PersonMailingCity == ''){
                        cityField.set("v.errors", [{message:""}]);
                    } else {
                        cityField.set("v.errors", null);
                    } 
                    if(item.PersonMailingPostalCode == null || item.PersonMailingPostalCode == ''){
                        postalcodeField.set("v.errors", [{message:""}]);
                    } else {
                        postalcodeField.set("v.errors", null);
                    } 
                    if(item.PersonMailingCountry == null || item.PersonMailingCountry == ''){
                        $A.util.addClass(countryField, 'changeMe');
                    }
                    else {
                        $A.util.removeClass(countryField, 'changeMe');
                    }
                } else {
                    streetField.set("v.errors", null);
                    cityField.set("v.errors", null);
                    postalcodeField.set("v.errors", null);
                    $A.util.removeClass(countryField, 'changeMe');
                } 
            }
            
        } else {
            streetField.set("v.errors", null);
            cityField.set("v.errors", null);
            postalcodeField.set("v.errors", null);
            if(locale == 'US'){
                stateField.set("v.errors", null);
            }
        }
        
        /* CONTROL FOR PRIVACY

        if(locale != 'DE'){
            var check1_yes = cmp.find('checkbox_1_yes');
            var check1_no = cmp.find('checkbox_1_no');
            var check1_label = cmp.find('checkbox_1_label');
            var check2_yes = cmp.find("checkbox_2_yes");
            var check2_no  = cmp.find("checkbox_2_no");
            var check2_label = cmp.find('checkbox_2_label');
            var check3_yes = cmp.find("checkbox_3_yes");
            var check3_no  = cmp.find("checkbox_3_no");
            var check3_label = cmp.find('checkbox_3_label');
            if(locale == 'JP'){
                if(item.Privacy1__c == null || item.Privacy2__c == null){
                    validitem = false;
                    errors.push('You must specify whether you give your consent or not to privacy');
                    if(item.Privacy1__c == null){
                        $A.util.addClass(check1_label, 'changeMeLabel');
                    } else {
                        $A.util.removeClass(check1_label, 'changeMeLabel');
                    } 
                    if(item.Privacy2__c == null){
                        $A.util.addClass(check2_label, 'changeMeLabel');
                    } else {
                        $A.util.removeClass(check2_label, 'changeMeLabel');
                    }               
                } else {
                    $A.util.removeClass(check1_label, 'changeMeLabel');
                    $A.util.removeClass(check2_label, 'changeMeLabel');
                }

            } else {
                if(item.Privacy1__c == null || item.Privacy2__c == null || item.Privacy3__c == null){
                    validitem = false;
                    errors.push('You must specify whether you give your consent or not to privacy');
                    if(item.Privacy1__c == null){
                        $A.util.addClass(check1_label, 'changeMeLabel');
                    } else {
                        $A.util.removeClass(check1_label, 'changeMeLabel');
                    } 
                    if(item.Privacy2__c == null){
                        $A.util.addClass(check2_label, 'changeMeLabel');
                    } else {
                        $A.util.removeClass(check2_label, 'changeMeLabel');
                    } 
                    if(item.Privacy3__c == null){
                        $A.util.addClass(check3_label, 'changeMeLabel');
                    } else {
                        $A.util.removeClass(check3_label, 'changeMeLabel');
                    }                
                } else {
                    $A.util.removeClass(check1_label, 'changeMeLabel');
                    $A.util.removeClass(check2_label, 'changeMeLabel');
                    $A.util.removeClass(check3_label, 'changeMeLabel');
                }

            }      
        }
        
        */
        
        if(validitem){
            
            helper.showSpinner(cmp);

            cmp.set("v.errors", null);
            var update = cmp.get("v.isUpdate");

            if(update){
                var action = cmp.get("c.updateNewAccount");
                action.setParams({ 
                    "account" : cmp.get("v.newItem"), 
                    "sPad64"  : signField_value
                });
                action.setCallback(this, function(response) {
                    var state = response.getState();

                    setTimeout(function(){
                        //do what you need here
                        cmp.set("v.isOpen", false);
                        cmp.set("v.formOpen", false);
                        cmp.set("v.successOpen", true);
                    }, 500);
                                
                });
                $A.enqueueAction(action);

            } else {
                var action = cmp.get("c.saveNewAccount");
                action.setParams({ 
                    "account" : cmp.get("v.newItem"), 
                    "sPad64"  : signField_value
                });
                action.setCallback(this, function(response) {
                    var state = response.getState();

                    setTimeout(function(){
                        //do what you need here
                        cmp.set("v.isOpen", false);
                        cmp.set("v.formOpen", false);
                        cmp.set("v.successOpen", true);
                    }, 500);
                                
                });
                $A.enqueueAction(action);
            }

        } else {
            cmp.set("v.buttonDisable",false);
            cmp.set("v.errors",errors);
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
        
        /*
        if(validitem){
            cmp.set("v.isValid", true);
            cmp.set("v.errors", null);
            cmp.set("v.afterPrinting", true);
            
            setTimeout(function(){
                window.focus();
                window.print();
                cmp.set("v.isDisabled", false);                
            }, 500);
            
        } else {
            cmp.set("v.errors",errors);
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
        */
        
	},

    handleError:function(cmp,event,helper){
        var comp = event.getSource();
        $A.util.addClass(comp, "error");   
    },

    handleClearError:function(cmp,event,helper){
        var comp = event.getSource();
        $A.util.removeClass(comp, "error");   
    },

    verifyCheckBox:function(cmp,event,helper){
        var test = event.getSource().getLocalId().split('_');
        console.log(test);
        
        console.log('value: ' + event.getSource().get("v.checked"));
        if(event.getSource().get("v.checked")){
            cmp.set("v.newItem." + test[1] + '__c', true);
        } else {
            cmp.set("v.newItem." + test[1] + '__c', null);
            if(test[1] == 'Other'){
                cmp.set("v.newItem.Other_text__c", "");
            }
        }
    },
    
    verifyCheckQuestion:function(cmp,event,helper){
        var test = event.getSource().getLocalId().split('_');
        console.log(test);
        
        console.log('aq: ' + event.getSource().get("v.checked"));
        if(event.getSource().get("v.checked")){
            if(test[2] == "yes"){
                cmp.set("v.newItem" + '.Privacy' + test[1] + '__c', true);
                var cmpTargetNo = cmp.find('checkbox_' + test[1] + '_no');
                cmpTargetNo.set("v.checked", false);
                
            } else if(test[2] == "no"){
                cmp.set("v.newItem" + '.Privacy' + test[1] + '__c', false);
                var cmpTargetYes = cmp.find('checkbox_' + test[1] + '_yes');
                cmpTargetYes.set("v.checked", false);
            }
        } else {
            cmp.set("v.newItem" + '.Privacy' + test[1] + '__c', null);
        }
    },

    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },

    closeError: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        var cmpTarget = component.find('errors-container');
        $A.util.addClass(cmpTarget, 'uiInputDefaultError');
    },

    returnToForm: function(cmp, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        window.location.reload()
    },
    
    backButton:function(cmp,event,helper){
        window.open('/apex/RegistrationFormClose?core.apexpages.request.devconsole=1', '_parent');
    },

    
})