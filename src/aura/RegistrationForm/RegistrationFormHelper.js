({
    fetchPickListVal: function(component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.newItem"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                console.log(allValues);
                
                opts.push({
                    class: "optionClass",
                    label: "",
                    value: ""
                });
                
                for (var k in allValues){
                    opts.push({
                        class: "optionClass",
                        label: k,
                        value: allValues[k]
                    });
                }
                /*
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                */
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },

    fetchPickListCountryVal: function(component, fieldName, elementId) {

        console.log('fetchPickListCountryVal');
        
        var opts = [];

        opts.push({
            class: "optionClass",
            label: "",
            value: ""
        });

        var allValues = ['Australia', 'Austria', 'Belgium', 'Bulgaria', 'Canada', 'Chile', 'Czech Republic', 
                        'Italy', 'Kazakistan', 'Latvia', 'Lithuania', 'Luxembourg', 'Macao', 'Malaysia',
                        'Monaco', 'Netherlands', 'New Zealands', 'Norway', 'Poland', 'Portugal', 'Romania',
                        'Singapore', 'Slovakia', 'Slovenia', 'South Africa', 'South Korea', 'Spain', 'Sweden',
                        'Switzerland', 'Taiwan', 'Thailandia', 'Tunisia', 'Turkey', 'Ukraine', 'United Kingdom',
                        'United States', 'Россия', '中国', '日本'];
        
        var allValuesIso = ['AU', 'AT', 'BE', 'BG', 'CA', 'CL', 'CZ', 
                        'IT', 'KZ', 'LV', 'LT', 'LU', 'MO', 'MY',
                        'MC', 'NL', 'NZ', 'NO', 'PL', 'PT', 'RO',
                        'SG', 'SK', 'SI', 'ZA', 'KR', 'ES', 'SE',
                        'CH', 'TW', 'TH', 'TN', 'TR', 'UA', 'GB',
                        'US', 'RU', 'CN', 'JP'];
        
        

        for (var i = 0; i < allValues.length; i++) {
            opts.push({
                class: "optionClass",
                label: allValues[i],
                value: allValuesIso[i]
            });
        }

        component.find(elementId).set("v.options", opts);
    },
    
    resizeCanvas : function(canvas, width) {
        if (width >= 1024){
            canvas.width  = width/2;
        } else {
            canvas.width  = width - 10;
        }
        canvas.height = 200; 
        
        var context = canvas.getContext('2d');
        
    },

    setTranslation : function(component) {
        var action = component.get("c.getUserInformation");
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var usr = response.getReturnValue();
                var locale = (usr.Nation_Contact_Card__c == null) ? 'US' : usr.Nation_Contact_Card__c;
                var prefer_language = usr.Language_Contact_Card__c;
                var action = component.get('c.getTranslatorForm');
        
                action.setCallback(this,function(response){
                    if (response.getState() == "SUCCESS") {
                        var all_translation = new Object();
                        var multilanguage = false;

                        all_translation = JSON.parse(JSON.stringify(response.getReturnValue()));
                        component.set("v.translator", all_translation);

                        var locale_lang = (prefer_language == null) ? 'en' + '_' + locale.toUpperCase() : prefer_language.toLowerCase() + '_' + locale.toUpperCase();
                        console.log(locale_lang);
                        var all_key = Object.keys(all_translation);

                        var container = [];
                        all_key.forEach(key => {
                            if(key.includes(locale)){
                                container.push(key);
                            }
                        });
                        var optsLang = [];

                        container.forEach(element => {
                            var pick_lang = new Object();
                            pick_lang.class = 'optionClass';
                            pick_lang.label = element.split('_')[0];
                            pick_lang.value = element;
                            pick_lang.selected = (prefer_language == null) ? ('en'.localeCompare(element.split('_')[0]) == 0) ? 'true' : '' : (prefer_language.localeCompare(element.split('_')[0]) == 0) ? 'true' : '';                            
                            optsLang.push(pick_lang);
                        });

                        if(optsLang.length <= 1){
                            var picklistShow = component.find("picklistShow");
                            $A.util.addClass(picklistShow, "notShowPicklist");
                            $A.util.removeClass(picklistShow, "slds-grid");
                            $A.util.removeClass(picklistShow, "slds-wrap");
                        }
                
                        component.find("InputSelectDynamicLanguage").set("v.options", optsLang); 
                        
                        var usr_translation = new Object();
                        usr_translation.Language_Label__c                 = all_translation[locale_lang].Language_Label__c;
                        usr_translation.Subheader_Label__c                = all_translation[locale_lang].Subheader_Label__c;
                        usr_translation.Salutation_Label__c               = all_translation[locale_lang].Salutation_Label__c;
                        usr_translation.First_Name_Label__c               = all_translation[locale_lang].First_Name_Label__c;
                        usr_translation.First_Name_Placeholder__c         = all_translation[locale_lang].First_Name_Placeholder__c;
                        usr_translation.Last_Name_Label__c                = all_translation[locale_lang].Last_Name_Label__c;
                        usr_translation.Last_Name_Placeholder__c          = all_translation[locale_lang].Last_Name_Placeholder__c;
                        usr_translation.Street_Label__c                   = all_translation[locale_lang].Street_Label__c;
                        usr_translation.Street_Placeholder__c             = all_translation[locale_lang].Street_Placeholder__c;
                        usr_translation.City_Label__c                     = all_translation[locale_lang].City_Label__c;
                        usr_translation.City_Placeholder__c               = all_translation[locale_lang].City_Placeholder__c;
                        usr_translation.State_Label__c                    = all_translation[locale_lang].State_Label__c;
                        usr_translation.State_Placeholder__c              = all_translation[locale_lang].State_Placeholder__c;
                        usr_translation.CAP_Label__c                      = all_translation[locale_lang].CAP_Label__c;
                        usr_translation.CAP_Placeholder__c                = all_translation[locale_lang].CAP_Placeholder__c;
                        usr_translation.Country_Label__c                  = all_translation[locale_lang].Country_Label__c;
                        usr_translation.Country_Placeholder__c            = all_translation[locale_lang].Country_Placeholder__c;
                        usr_translation.Phone_Label__c                    = all_translation[locale_lang].Phone_Label__c;
                        usr_translation.Phone_Placeholder__c              = all_translation[locale_lang].Phone_Placeholder__c;
                        usr_translation.Mobile_Label__c                   = all_translation[locale_lang].Mobile_Label__c;
                        usr_translation.Mobile_Placeholder__c             = all_translation[locale_lang].Mobile_Placeholder__c;
                        usr_translation.Email_Label__c                    = all_translation[locale_lang].Email_Label__c;
                        usr_translation.Email_Placeholder__c              = all_translation[locale_lang].Email_Placeholder__c;
                        usr_translation.We_Chat_ID_Label__c                    = all_translation[locale_lang].We_Chat_ID_Label__c;
                        usr_translation.We_Chat_ID_Placeholder__c              = all_translation[locale_lang].We_Chat_ID_Placeholder__c;
                        usr_translation.Checkbox_Phone_Label__c           = all_translation[locale_lang].Checkbox_Phone_Label__c;
                        usr_translation.Contact_Preferences_Label__c      = all_translation[locale_lang].Contact_Preferences_Label__c;
                        usr_translation.Checkbox_Email_Label__c           = all_translation[locale_lang].Checkbox_Email_Label__c;
                        usr_translation.Checkbox_WeChat_Label__c           = all_translation[locale_lang].Checkbox_WeChat_Label__c;
                        usr_translation.Checkbox_Mail_Label__c            = all_translation[locale_lang].Checkbox_Mail_Label__c;
                        usr_translation.Checkbox_Other_Label__c           = all_translation[locale_lang].Checkbox_Other_Label__c;
                        usr_translation.Checkbox_Other_Placeholder__c     = all_translation[locale_lang].Checkbox_Other_Placeholder__c;
                        usr_translation.Birthdate_Label__c                = all_translation[locale_lang].Birthdate_Label__c;
                        usr_translation.Gender_Label__c                   = all_translation[locale_lang].Gender_Label__c;
                        usr_translation.Nationality_Label__c                   = all_translation[locale_lang].Nationality_Label__c;
                        usr_translation.Preferred_Language_Label__c       = all_translation[locale_lang].Preferred_Language_Label__c;
                        //usr_translation.Privacy_Header_Label__c           = all_translation[locale_lang].Privacy_Header_Label__c; //Akshay Not in Use
                        usr_translation.Privacy_Header_Before_Link_Label__c= all_translation[locale_lang].Privacy_Header_Before_Link_Label__c;
                        usr_translation.Privacy_Header_Link_Label__c	  = all_translation[locale_lang].Privacy_Header_Link_Label__c;
                        usr_translation.Privacy_Header_After_Link_Label__c	= all_translation[locale_lang].Privacy_Header_After_Link_Label__c;
                        usr_translation.Privacy_Yes_Label__c              = all_translation[locale_lang].Privacy_Yes_Label__c;
                        usr_translation.Privacy_No_Label__c               = all_translation[locale_lang].Privacy_No_Label__c;
                        usr_translation.Privacy_1_Label__c                = all_translation[locale_lang].Privacy_1_Label__c;
                        usr_translation.Privacy_2_Label__c                = all_translation[locale_lang].Privacy_2_Label__c;
                        usr_translation.Privacy_2_Label_Department__c                = all_translation[locale_lang].Privacy_2_Label_Department__c;
                        usr_translation.Privacy_3_Label__c                = all_translation[locale_lang].Privacy_3_Label__c;
                        usr_translation.Privacy_Footer_Label__c           = all_translation[locale_lang].Privacy_Footer_Label__c;                        
                        usr_translation.Date_Label__c                     = all_translation[locale_lang].Date_Label__c;
                        usr_translation.Signature_Label__c                = all_translation[locale_lang].Signature_Label__c;
                        usr_translation.Button_Signature_Clear_Label__c   = all_translation[locale_lang].Button_Signature_Clear_Label__c;
                        usr_translation.Button_Signature_Save_Label__c    = all_translation[locale_lang].Button_Signature_Save_Label__c;
                        usr_translation.Signature_Asterisco_Label__c      = all_translation[locale_lang].Signature_Asterisco_Label__c;
                        usr_translation.Button_Form_Registration_Label__c = all_translation[locale_lang].Button_Form_Registration_Label__c;
                        usr_translation.Informativa_Header_Label__c       = all_translation[locale_lang].Informativa_Header_Label__c;
                        usr_translation.Informativa_Body_Rich_Label__c    = all_translation[locale_lang].Informativa_Body_Rich_Label__c;
                        usr_translation.Informativa_Body_Rich_Label_Department__c    = all_translation[locale_lang].Informativa_Body_Rich_Label_Department__c;

                        
                        component.set("v.translatorValue", usr_translation); 
                        component.set("v.multiLanguage", multilanguage); 
                        component.set("v.language", locale_lang); 
                        component.set("v.locale", locale_lang.split('_')[1]);

                        if(locale_lang.split('_')[1] == 'JP'){
                            var checkbox_border = component.find("checkbox2");
                            $A.util.removeClass(checkbox_border, "border-bottom");

                        }
                    }
                });
                $A.enqueueAction(action);

            }
        });
        $A.enqueueAction(action);
        
    },

    setTranslationInPicklist : function(component) {
        var language = component.get("v.language");
        console.log(language);
        var all_translation = component.get("v.translator");
        var usr_translation = new Object();
        usr_translation.Language_Label__c                 = all_translation[language].Language_Label__c;
        usr_translation.Subheader_Label__c                = all_translation[language].Subheader_Label__c;
        usr_translation.Salutation_Label__c               = all_translation[language].Salutation_Label__c;
        usr_translation.First_Name_Label__c               = all_translation[language].First_Name_Label__c;
        usr_translation.First_Name_Placeholder__c              = all_translation[language].First_Name_Placeholder__c;
        usr_translation.Last_Name_Label__c                = all_translation[language].Last_Name_Label__c;
        usr_translation.Last_Name_Placeholder__c               = all_translation[language].Last_Name_Placeholder__c;
        usr_translation.Street_Label__c                   = all_translation[language].Street_Label__c;
        usr_translation.Street_Placeholder__c             = all_translation[language].Street_Placeholder__c;
        usr_translation.City_Label__c                     = all_translation[language].City_Label__c;
        usr_translation.City_Placeholder__c               = all_translation[language].City_Placeholder__c;
        usr_translation.State_Label__c                    = all_translation[language].State_Label__c;
        usr_translation.State_Placeholder__c              = all_translation[language].State_Placeholder__c;
        usr_translation.CAP_Label__c                      = all_translation[language].CAP_Label__c;
        usr_translation.CAP_Placeholder__c                = all_translation[language].CAP_Placeholder__c;
        usr_translation.Country_Label__c                  = all_translation[language].Country_Label__c;
        usr_translation.Country_Placeholder__c            = all_translation[language].Country_Placeholder__c;
        usr_translation.Phone_Label__c                    = all_translation[language].Phone_Label__c;
        usr_translation.Phone_Label__c                    = all_translation[language].Phone_Label__c;
        usr_translation.Mobile_Label__c                   = all_translation[language].Mobile_Label__c;
        usr_translation.Mobile_Placeholder__c             = all_translation[language].Mobile_Placeholder__c;
        usr_translation.Email_Label__c                    = all_translation[language].Email_Label__c;
        usr_translation.Email_Placeholder__c              = all_translation[language].Email_Placeholder__c;
        usr_translation.We_Chat_ID_Label__c                    = all_translation[language].We_Chat_ID_Label__c;
        usr_translation.We_Chat_ID_Placeholder__c              = all_translation[language].We_Chat_ID_Placeholder__c;
        usr_translation.Checkbox_Phone_Label__c           = all_translation[language].Checkbox_Phone_Label__c;
        usr_translation.Contact_Preferences_Label__c      = all_translation[language].Contact_Preferences_Label__c;
        usr_translation.Checkbox_Email_Label__c           = all_translation[language].Checkbox_Email_Label__c;
        usr_translation.Checkbox_WeChat_Label__c           = all_translation[language].Checkbox_WeChat_Label__c;
        usr_translation.Checkbox_Mail_Label__c            = all_translation[language].Checkbox_Mail_Label__c;
        usr_translation.Checkbox_Other_Label__c           = all_translation[language].Checkbox_Other_Label__c;
        usr_translation.Checkbox_Other_Placeholder__c     = all_translation[language].Checkbox_Other_Placeholder__c;
        usr_translation.Birthdate_Label__c                = all_translation[language].Birthdate_Label__c;
        usr_translation.Gender_Label__c                   = all_translation[language].Gender_Label__c;
        usr_translation.Nationality_Label__c                   = all_translation[language].Nationality_Label__c;
        usr_translation.Preferred_Language_Label__c       = all_translation[language].Preferred_Language_Label__c;
        //usr_translation.Privacy_Header_Label__c           = all_translation[language].Privacy_Header_Label__c; //Akshay Not in Use
        usr_translation.Privacy_Header_Before_Link_Label__c = all_translation[language].Privacy_Header_Before_Link_Label__c;
        usr_translation.Privacy_Header_Link_Label__c		= all_translation[language].Privacy_Header_Link_Label__c;
        usr_translation.Privacy_Header_After_Link_Label__c	= all_translation[language].Privacy_Header_After_Link_Label__c;
        usr_translation.Privacy_Yes_Label__c              = all_translation[language].Privacy_Yes_Label__c;
        usr_translation.Privacy_No_Label__c               = all_translation[language].Privacy_No_Label__c;
        usr_translation.Privacy_1_Label__c                = all_translation[language].Privacy_1_Label__c;
        usr_translation.Privacy_2_Label__c                = all_translation[language].Privacy_2_Label__c;
        usr_translation.Privacy_2_Label_Department__c                = all_translation[language].Privacy_2_Label_Department__c;
        usr_translation.Privacy_3_Label__c                = all_translation[language].Privacy_3_Label__c;
        usr_translation.Privacy_Footer_Label__c           = all_translation[language].Privacy_Footer_Label__c;                        
        usr_translation.Date_Label__c                     = all_translation[language].Date_Label__c;
        usr_translation.Signature_Label__c                = all_translation[language].Signature_Label__c;
        usr_translation.Button_Signature_Clear_Label__c   = all_translation[language].Button_Signature_Clear_Label__c;
        usr_translation.Button_Signature_Save_Label__c    = all_translation[language].Button_Signature_Save_Label__c;
        usr_translation.Signature_Asterisco_Label__c      = all_translation[language].Signature_Asterisco_Label__c;
        usr_translation.Button_Form_Registration_Label__c = all_translation[language].Button_Form_Registration_Label__c;
        usr_translation.Informativa_Header_Label__c       = all_translation[language].Informativa_Header_Label__c;
        usr_translation.Informativa_Body_Rich_Label__c    = all_translation[language].Informativa_Body_Rich_Label__c;
        usr_translation.Informativa_Body_Rich_Label_Department__c    = all_translation[language].Informativa_Body_Rich_Label_Department__c;
        
        component.set("v.translatorValue", usr_translation); 
        
    },

    getAccountFields : function(component, id) {
        console.log('ID: ' +id);
        var action = component.get("c.getAccount");
        action.setParams({
            "AccountId": id
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var acc = response.getReturnValue();
                // reset privacy
                acc.Privacy1__c = null;
                acc.Privacy2__c = null;
                acc.Privacy3__c = null;
                console.log(acc);
                component.set("v.newItem", acc);
                component.set("v.isUpdate", true);
            } else {
                component.set("v.isUpdate", false);
            }
        });
        $A.enqueueAction(action);
        
    },
    
    isCanvasTransparent : function(canvas) { // true if all pixels Alpha equals to zero
        var ctx=canvas.getContext("2d");
        var imageData=ctx.getImageData(0,0,canvas.offsetWidth,canvas.offsetHeight);
        for(var i=0;i<imageData.data.length;i+=4)
            if(imageData.data[i+3]!==0)return false;
        
        return true;
    },
    
    getUserInfo : function(component) {
        var action = component.get("c.getUserInformation");
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var usr = response.getReturnValue();
                console.log(usr);
                component.set("v.user", usr);
            } else {
                component.set("v.user", null);
            }
        });
        $A.enqueueAction(action);      
        
        return true; 
    },
    
    showSpinner: function (cmp, event, helper) {
        var spinner = cmp.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
        
    },
    
    hideSpinner: function (cmp, event, helper) {
        var spinner = cmp.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
        
    },
    
})