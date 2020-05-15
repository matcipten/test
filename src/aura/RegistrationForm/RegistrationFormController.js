({
    
    doInit : function(component, event, helper) {
        console.log("INIT CONTROLLER");  
        component.set("v.newItem","{'sobjectType':'Account'}");
        var today = new Date();
        helper.getUserInfo(component);
        component.set('v.myDateTime', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
         // helper.fetchPickListVal(component, 'Professione__c', 'InputSelectDynamicProfession');
        // helper.fetchPickListVal(component, 'Hobby__c', 'InputSelectDynamicHobby');
        helper.fetchPickListVal(component, 'Salutation', 'InputSelectDynamicTitolo');
        helper.fetchPickListVal(component, 'Sesso__c', 'InputSelectDynamicGenere');
        // helper.fetchPickListVal(component, 'Nazionalita__c', 'InputSelectDynamicNationality');
        // helper.fetchPickListVal(component, 'Lingua__c', 'InputSelectDynamicLang');
        // helper.fetchPickListVal(component, 'Nazionalita__c', 'InputSelectDynamicCountry');
        // helper.fetchPickListVal(component, 'Nazionalita__c', 'InputSelectDynamicPassportCountry');

        //PALUMBO (START)
        // helper.fetchPickListVal(component, 'Nazionalita__c', 'InputSelectDynamicContactCountry');
        // helper.fetchPickListVal(component, 'Nazionalita__c', 'InputSelectDynamicOtherCountry');
        //PALUMBO (END)
		
        helper.fetchPickListVal2(component, 'Nazionalita__c', 'InputSelectDynamicCountry', 'Country');
        helper.fetchPickListVal2(component, 'Nazionalita__c', 'InputSelectDynamicNationality', 'Nationality');
        helper.fetchPickListVal2(component, 'Professione__c', 'InputSelectDynamicProfession', 'Profession');
        helper.fetchPickListVal2(component, 'Lingua__c', 'InputSelectDynamicLang', 'PreferredLanguage');
        helper.fetchPickListVal2(component, 'Hobby__c', 'InputSelectDynamicHobby', 'Hobby');
        helper.fetchPickListVal2(component, 'Nazionalita__c', 'InputSelectDynamicContactCountry', "CountryOther");
        helper.fetchPickListVal2(component, 'Nazionalita__c', 'InputSelectDynamicOtherCountry', "CountryContact");

        var myPageRef = component.get("v.pageReference");
        if(myPageRef){
            var accId = myPageRef.state.c__recordId;
            helper.getAccountFields(component, accId);   
            //PALUMBO (START)
            if (accId !=undefined){
                component.set("v.DCCBool",true);
            }            
            //PALUMBO (END)        
        }else{
            helper.getAccountFields(component, '');      
        }
        
        
        helper.setTranslation(component);      
        
        
        component.set("v.successOpen", false);
        component.set("v.formOpen", true);
        
        
      
    },
    initDefaultCountry:function(cmp){
      console.log("TEST");  
    },
    
    doneRendering: function(cmp, event, helper) {
        var signaturePad;
        var canvas = cmp.find("canvas").getElement();
        var width = document.getElementById("canvas").offsetWidth;
        cmp.set("v.width", width);
        //console.log('width : ' + width);
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
        component.set('v.truncLanguage',picklistValue.substring(0,2));
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
        cmp.set("v.newItem.SignedLanguage__c",cmp.get("v.language").substring(0,2));
        //cmp.set("v.buttonDisable",true);
        
        var sign = cmp.find("canvas").getElement();
        var is_canvas_blank = helper.isCanvasTransparent(sign);
       // console.log('is canvas transparent: ' + is_canvas_blank);
        
        if(is_canvas_blank){
            cmp.set("v.sPad64", '');
        } else {
            cmp.set("v.sPad64", sign.toDataURL());
        }
        
        // location__c --> Select id from Location__c where id_location__c =: User.Codice_Boutique__c
        // Id_location__c --> User.Codice_Boutique__c
        var locale = cmp.get("v.locale");
        var truncateLanguage = cmp.get("v.truncLanguage");
        //console.log('locale: ' + locale);
        var item = cmp.get("v.newItem");
        //console.log('item: ' + item);
        var errors = [];
        var validitem = true;
        
        var cmpTarget = cmp.find('errors-container');
        $A.util.removeClass(cmpTarget, 'uiInputDefaultError');
        
        if(locale == 'JP' || locale == 'CN'  || locale == 'RU' ||  locale == 'HK' ||  locale == 'MO' || truncateLanguage == 'ja'|| truncateLanguage == 'zh' || truncateLanguage == 'ru'){
            var nameFieldJp = cmp.find("itemNameJC");
            if(item.FirstName == null || item.FirstName == ''){
                validitem = false;
                nameFieldJp.set("v.errors", [{message:""}]);
                errors.push('Please enter First Name');
            } else {
                nameFieldJp.set("v.errors",null);
            }
            
            var surnameFieldJp = cmp.find("itemSurnameJC");
            if(item.LastName == null || item.LastName == ''){
                validitem = false;
                surnameFieldJp.set("v.errors", [{message:""}]);
                errors.push('Please enter Last Name');
            } else {
                surnameFieldJp.set("v.errors",null);
            }
            //SALESFORCE-657 ->
        	var nameField = cmp.find("itemNameJC");
            if(!helper.checkNotAnsiChars(item.FirstName)){
                validitem = false;
                nameField.set("v.errors", [{message:""}]);
                errors.push('Please use the Local Name Field');
            } else {
                nameField.set("v.errors",null);
            }
            
            var surnameField = cmp.find("itemSurnameJC");
            if(!helper.checkNotAnsiChars(item.LastName)){
                validitem = false;
                surnameField.set("v.errors", [{message:""}]);
                errors.push('Please use the Local Last Name Field');
            } else {
                surnameField.set("v.errors",null);
            }
        	//SALESFORCE-657 <-
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
            //SALESFORCE-657 ->
        	var nameField = cmp.find("itemName");
            if(!helper.checkNotAnsiChars(item.FirstName)){
                validitem = false;
                nameField.set("v.errors", [{message:""}]);
                errors.push('Please use the Local Name Field');
            } else {
                nameField.set("v.errors",null);
            }
            
            var surnameField = cmp.find("itemSurname");
            if(!helper.checkNotAnsiChars(item.LastName)){
                validitem = false;
                surnameField.set("v.errors", [{message:""}]);
                errors.push('Please use the Local Last Name Field');
            } else {
                surnameField.set("v.errors",null);
            }
        	//SALESFORCE-657 <-
        }
        	

        
            
        
        var canvas = cmp.find("canvas");
        var signField_value = cmp.get("v.sPad64");
       // console.log('signField_value: ' + signField_value);
        if (!signField_value || signField_value == ''){
			
            var permissionChanged = false;
            var DCCVersionChanged = false;
            var DCCFalse = false;
            
            if ( cmp.get("{!v.newItem.Privacy1__c}") != cmp.get("{!v.Privacy_1_old}") || cmp.get("{!v.newItem.Privacy2__c}") != cmp.get("{!v.Privacy_2_old}") || cmp.get("{!v.newItem.Privacy3__c}") != cmp.get("{!v.Privacy_3_old}"))
                permissionChanged = true;
            
            console.log("permissionChanged:" + permissionChanged);
            
            // VSchia 31/03/2020 ISSUE 795
            // rimosso controllo su DCCVersion_old quando è null o una stringa vuota
            /*if ( ( cmp.get("{!v.DCCVersion_old}") != cmp.get("{!v.TranslationDCCVersion}") && cmp.get("{!v.TranslationRichiediFirma}") == true) || cmp.get("{!v.DCCVersion_old}") == null || cmp.get("{!v.DCCVersion_old}") == "" )
                DCCVersionChanged = true;*/
            if ( ( cmp.get("{!v.DCCVersion_old}") != cmp.get("{!v.TranslationDCCVersion}") && cmp.get("{!v.TranslationRichiediFirma}") == true))
                DCCVersionChanged = true;
            // VSchia 31/03/2020 ISSUE 795


            /* 26022020 Silvio - tkt:795
            if (cmp.get("{!v.DCC}") == false)
            	DCCFalse = true;
            */
            
             console.log("DCCVersion_old:" + cmp.get("{!v.DCCVersion_old}"));
             console.log("TranslationDCCVersion:" + cmp.get("{!v.TranslationDCCVersion}"));
             console.log("TranslationRichiediFirma:" + cmp.get("{!v.TranslationRichiediFirma}"));

            
            console.log("DCCVersionChanged:" + DCCVersionChanged);
            console.log("DCC:" + cmp.get("{!v.DCC}"));
            // VSchia 31/03/2020 ISSUE 795  rimosso da l'if di seguito|| DCCFalse
            if (permissionChanged || DCCVersionChanged){
                validitem = false;
                $A.util.addClass(canvas, 'changeMe');
                errors.push('Remember to Sign and Save');
            }
            // VSchia 31/03/2020 ISSUE 795
        }
        else {
            $A.util.removeClass(canvas, 'changeMe');
        }
        
        var phoneField  = cmp.find("itemPhone");
        //var mobileField = cmp.find("itemPersonMobilePhone");
        if(item.Telefono__c){
            if((item.Phone == null || item.Phone == '')){
                validitem = false;
                phoneField.set("v.errors", [{message:"phone"}]);
                //mobileField.set("v.errors", [{message:"mobile"}]);
                errors.push('If you want to be contacted by phone, enter a phone');
            } else {
                phoneField.set("v.errors", null);
                //mobileField.set("v.errors", null);
            }
        } else {
            phoneField.set("v.errors", null);
            //mobileField.set("v.errors", null);
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
        
        //MC- Start 
        console.log("MC-1");
        //var day = parseInt(document.getElementById("InputDayBirthdate").value,10);
        //var month = parseInt(document.getElementById("InputMonthBirthdate").value,10);
        //var year = parseInt(document.getElementById("InputYearBirthdate").value,10);
        
        //console.log("Day: " + day + " -- Month: " + month + " -- Year: " + year);
        //check days and month

        var day = cmp.get("v.dayBirthdate");
        var month = cmp.get("v.monthBirthdate");
        var year = cmp.get("v.yearBirthdate");
        console.log("Day: " + day + " -- Month: " + month + " -- Year: " + year);

        if((day == '' || day == null) && (month == '' || month == null)){
            $A.util.removeClass(cmp.find("InputDayBirthdate"), 'changeMe');
            $A.util.removeClass(cmp.find("InputMonthBirthdate"), 'changeMe');
        }else{
            day = parseInt(day);
            month = parseInt(month);
            year = parseInt(year);
            console.log("Day: " + day + " -- Month: " + month + " -- Year: " + year);
            /*
            if(isNaN(day) || isNaN(month)){
                $A.util.addClass(cmp.find("InputDayBirthdate"), 'changeMe');
                $A.util.addClass(cmp.find("InputMonthBirthdate"), 'changeMe');
                errors.push("Day and month must be a number");
                //$A.util.removeClass(cmp.find("InputDayBirthdate"), 'changeMe');
                //$A.util.removeClass(cmp.find("InputMonthBirthdate"), 'changeMe');
            /*}else if((isNaN(day) && !isNaN(month)) || (isNaN(month) && !isNaN(day))){
                validitem = false;
                if(isNaN(day)) {
                    $A.util.addClass(cmp.find("InputDayBirthdate"), 'changeMe');
                    errors.push("Insert the day too");
                }
                if(isNaN(month)) {
                    $A.util.addClass(cmp.find("InputMonthBirthdate"), 'changeMe');
                    errors.push("Insert the Month too");
                }
                
        }else */
            if(!helper.isDayInRange(day) || !helper.isMonthInRange(month)){
                //day or month not in range
                validitem = false;
                if(!helper.isDayInRange(day)){
                    $A.util.addClass(cmp.find("InputSelectDay"), 'changeMe');
                    errors.push("Invalid value for Day");
                }
                if(!helper.isMonthInRange(month)){
                    $A.util.addClass(cmp.find("InputSelectMonth"), 'changeMe');
                    errors.push("Invalid value for Month");
                }
               
            }else{
                if(!helper.isValidDay(day,month,year)){
                    console.log("MC-2");
                    validitem = false;
                    $A.util.addClass(cmp.find("InputSelectDay"), 'changeMe');
                    errors.push("Day invalid for Month selected");
                }else{
                    console.log("MC-3");
                    $A.util.removeClass(cmp.find("InputSelectDay"), 'changeMe');
                    $A.util.removeClass(cmp.find("InputSelectMonth"), 'changeMe');
                    if(year == "" || year == null || isNaN(year)){
                        year = 2038;
                    }
                    //var d = new Date(year + "-" + month + "-" + day);
                    //console.log("MC-3.1 d: " + d);
                    //component.set('v.newItem.PersonBirthdate', d.getFullYear() + "-" + d.getMonth() + "-" + d.getDate());
                    console.log("MC-3.1 Year-Month-Day: " + year + "--" + month + "--" + day);
                    cmp.set("v.newItem.PersonBirthdate",new Date(Date.UTC(year, month-1, day)));//new Date(year,month -1,day,1,0,0));
                    console.log("MC-3.2 v.newItem.PersonBirthdate: " + cmp.get("v.newItem.PersonBirthdate"));   
                } 
            } 
        }  
        
        //MC- End


        /* MC- Start Temporaneamente disattivato controllo età
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
        MC- End*/

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
        //Akshay 22/01/2019
        if (locale != 'US' && locale != 'CA'){
        var passportNumField      = cmp.find("itemPassportNum");
        var luogoField      = cmp.find("InputSelectDynamicPassportCountry");
        var enteField = cmp.find("itemPassportIssuedBy");
        var dataissuedField = cmp.find("itemPassportIssuedOn");    
            if (enteField)
                enteField.set("v.errors", null);
            if (dataissuedField)
                enteField.set("v.errors", null);
            luogoField.set("v.errors", null);
        if(item.Numero_Passaporto__c != null && item.Numero_Passaporto__c != '' ){
            if(item.Paese_di_emissione_passaporto__c == null || item.Paese_di_emissione_passaporto__c ==''){
                validitem = false;
                errors.push('Please insert country of issue');
                luogoField.set("v.errors", [{message:""}]); //Data_di_emissione_passaporto__c
            }
            else if (locale == 'RU' && (item.Ente_di_emissione_passaporto__c == null || item.Ente_di_emissione_passaporto__c == ''))
            {
                validitem = false;
                errors.push('Please insert who issue the passport');
                enteField.set("v.errors", [{message:""}]); 
            }
            else if (locale == 'RU' && (item.Data_di_emissione_passaporto__c == null || item.Data_di_emissione_passaporto__c == ''))
            {
                validitem = false;
                errors.push('Please insert when the passport was issued');
                dataissuedField.set("v.errors", [{message:""}]); 
            }
            else {
                luogoField.set("v.errors", null);
                if (enteField)
                    enteField.set("v.errors", null);
                if (dataissuedField)
                    enteField.set("v.errors", null);
            } 
        }
        
        if(item.Paese_di_emissione_passaporto__c != null && item.Paese_di_emissione_passaporto__c !='' ){
            if(item.Numero_Passaporto__c == null || item.Numero_Passaporto__c == ''){
                validitem = false;
                errors.push('Please insert passport number');
                passportNumField.set("v.errors", [{message:""}]);
            } else {
                passportNumField.set("v.errors", null);
            } 
        }
        }
        if (locale == 'JP'){
            var streetField      = cmp.find("itemPersonMailingStreetJP");
            var cityField        = cmp.find("itemPersonMailingCityJP");
            var postalcodeField  = cmp.find("itemPersonMailingPostalCodeJP");
        }
        else{
            var streetField      = cmp.find("itemPersonMailingStreet");
            var cityField        = cmp.find("itemPersonMailingCity");
            var postalcodeField  = cmp.find("itemPersonMailingPostalCode");
        }
       
        var countryField     = cmp.find("inputCountry");  

        if(item.PersonMailingCountry == null || item.PersonMailingCountry == ''){
                validitem = false;
                errors.push('Please insert customer country');
                countryField.set("v.messageWhenBadInput", [{message:""}]);
            } else {
                countryField.set("v.messageWhenBadInput", null);
            } 
        
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
        /* CHECK FOR CHECKBOX, a choose is mandatory for each checkbox*/
        	var isAnUpdate = cmp.get("v.isUpdate");
 			var check1_yes = cmp.find('checkbox_1_yes');
            var check1_no = cmp.find('checkbox_1_no');
            var check1_label = cmp.find('checkbox_1_label');
            var check2_yes = cmp.find("checkbox_2_yes");
            var check2_no  = cmp.find("checkbox_2_no");
            var check2_label = cmp.find('checkbox_2_label');
            var check3_yes = cmp.find("checkbox_3_yes");
            var check3_no  = cmp.find("checkbox_3_no");
            var check3_label = cmp.find('checkbox_3_label');
        if (!isAnUpdate){
            if(locale != 'DE'){
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
        
        /*CONTROL FOR PRIVACY

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

        //PALUMBO (START)
        if (!cmp.get("v.showContactAddress")){
            cmp.set("v.newItem.BillingCountry",'');
        }

        if (!cmp.get("v.showOtherAddress")){
            cmp.set("v.newItem.PersonOtherCountry",'');
        }

        //PALUMBO (END)

        
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
                    if(state =='SUCCESS'){
                        var allValues = JSON.parse(response.getReturnValue());
                        //console.log(allValues);
                        cmp.set("v.Id",allValues.Id);
                        //do what you need here
                        cmp.set("v.isOpen", false);
                        cmp.set("v.formOpen", false);
                        cmp.set("v.successOpen", true);
                        
                    }else if (state=="ERROR") {
                        var errorMsg = action.getError()[0].message;
                        console.log(errorMsg);
                        
                        cmp.set("v.buttonDisable",false);
                        cmp.set("v.errors",errorMsg);
                        document.body.scrollTop = 0;
                        document.documentElement.scrollTop = 0;
                        helper.hideSpinner(cmp);
                        
                    }
                    
                    
                });
                $A.enqueueAction(action);
                
            } else {
               // console.log(cmp.get("v.newItem"));
                var action = cmp.get("c.saveNewAccount");
                action.setParams({ 
                    "account" : cmp.get("v.newItem"), 
                    "sPad64"  : signField_value
                });
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if(state =='SUCCESS'){
                        var allValues = JSON.parse(response.getReturnValue());
                        cmp.set("v.Id",allValues.Id);
                        //do what you need here
                        cmp.set("v.isOpen", false);
                        cmp.set("v.formOpen", false);
                        cmp.set("v.successOpen", true);
                        
                    }else if (state=="ERROR") {
                        var errorMsg = action.getError()[0].message;
                        console.log(errorMsg);
                        
                        cmp.set("v.buttonDisable",false);
                        cmp.set("v.errors",errorMsg);
                        document.body.scrollTop = 0;
                        document.documentElement.scrollTop = 0;
                        helper.hideSpinner(cmp);
                    }
                    
                    
                });
                $A.enqueueAction(action);
            }
            
        } else {
            cmp.set("v.buttonDisable",false);
            cmp.set("v.errors",errors);
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
            helper.hideSpinner(cmp);
        }
        
     
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
       // console.log(test);
        
       // console.log('value: ' + event.getSource().get("v.checked"));
        if(event.getSource().get("v.checked")){
            cmp.set("v.newItem." + test[1] + '__c', true);
        } else {
            cmp.set("v.newItem." + test[1] + '__c', null);
            if(test[1] == 'Messaging'){
                cmp.set("v.newItem.Other_text__c", "");
            }
        }
    },
    
    verifyCheckQuestion:function(cmp,event,helper){
        var test = event.getSource().getLocalId().split('_');
       // console.log(test);
        
       // console.log('aq: ' + event.getSource().get("v.checked"));
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
        //window.open('/apex/RegistrationFormClose?core.apexpages.request.devconsole=1', '_parent');
        var myPageRef = cmp.get("v.pageReference");
        if(myPageRef){
            var accId = myPageRef.state.c__recordId;
            cmp.set("v.Id",accId);
        }else{
           cmp.set("v.Id",'');
        }
        

        var update = cmp.get("v.isUpdate");
        var record = cmp.get("v.Id");
        //console.log(record);
        if(update && record != null){
            var navService = cmp.find("navService");
            var pageReference = {    
                "type": "standard__recordPage",
                "attributes": {
                    "recordId": record,
                    "objectApiName": "Account",
                    "actionName": "view"
                }
            }
            navService.navigate(pageReference);
        }else {
            var navService = cmp.find("navService");
            var pageReference = {
                "type": "standard__namedPage",
                "attributes": {
                    "pageName": "home"
                }
            }
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": '/lightning/n/Home_Page_Mobile_Client_Advisor'
            });
            urlEvent.fire();
            //navService.navigate(pageReference); //commented since it is not working with mobile app
        }
    },
    
    blockScroll:function(cmp,event,helper){
        event.preventDefault();
        event.stopPropagation();
    },
    
    changeState : function changeState (component){ 
        var rotateSvg =  component.find('articleOne');
        if(component.get('v.isexpanded')){
        	$A.util.addClass(rotateSvg, 'expandSection');
        }else{
            $A.util.removeClass(rotateSvg, 'expandSection');
        }
        
        component.set('v.isexpanded',!component.get('v.isexpanded'));
    },
    refreshCmp :function(component,event,helper){
        $A.get("e.force:refreshView").fire();
     
    },
    
    showbar : function(component, event, helper) {
        component.set("v.buttonDisable",true);
        component.set("v.viewBarcode", true);
        var recordId = component.get("v.Id");
        //console.log('newItem ' + recordId);
        //var barcode = component.get("v.barcode");
        //var barcode = document.getElementById("#barcode").JsBarcode("v.recordId");;        
        /*component.set("v.barcode", JsBarcode("#v.barcode","recordId",{
            fontOptions: "both",
            font :  "OCRB",
            textAlign : "center",
            Textmargin : 5,
            fontSize : 12,
            width: 1,
            height: 50
            
            }));*/
            
        let divDOM = document.getElementById("barcode");
        let svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        //svg.setAttribute('jsbarcode-format', 'ean13');
        //svg.setAttribute('jsbarcode-value', '1234567890128');
        svg.setAttribute('jsbarcode-value', recordId);
        svg.setAttribute('jsbarcode-width', 1);
        svg.className.baseVal = "barcode";
        divDOM.appendChild(svg);
        
        console.log(document.querySelector('.barcode'));
        JsBarcode(".barcode").init();
        

    },    

    //PALUMBO (START)
    handleAddressSection : function(component,event,helper){
        var sectionAuraId = event.target.getAttribute("data-auraId");  
        var sectionIcon =  event.target.getAttribute("data-iconId");     
        var sectionDiv = component.find(sectionAuraId).getElement();       
        var sectionState = sectionDiv.getAttribute('class').search('slds-is-open');         
        
        if(sectionState == -1){
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open');          
            $A.util.removeClass(component.find(sectionIcon),'expandSection');
        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close');
            $A.util.addClass(component.find(sectionIcon),'expandSection');
        }                
    },
    
    handleAddAddress : function(component,event,helper){
        var buttonSelected = event.getSource().getLocalId(); 
        if (buttonSelected == 'defaultAddButton'){            
            component.set("v.showContactAddress",true);
        }else {
            component.set("v.showOtherAddress",true);
        }
    },

    //PALUMBO (END) // VS - 20/04/2020 ISSUE 745
    onChangePickList: function (component, event, helper) {
        // var searchString = component.find("countryPicklist").get("v.value");;
        var searchString = event.getSource().get("v.value");
        var f = event.getSource().getLocalId().replace("input","");
        console.log("onChangePickList");
        helper.openListbox(component, searchString);
        helper.displayPredictions(component,f, searchString);
    },
    
    onFocusPickList: function (component, event, helper) {
        // var searchString = component.get("v.newItem.SingleLineAddress__c");
        console.log("onFocusPickList");
        var value = event.getSource().getLocalId()
        var searchString= value.replace("input","");
        
        helper.openListbox(component, "searchLookup"+searchString);
        //helper.displayPredictions(component, searchString);
    },
    onBlurPickList: function (component, event, helper) {
        var value = event.getSource().getLocalId()
        var searchString= value.replace("input","");
        console.log("onBlurPickList"+searchString);
        
        window.setTimeout(
            $A.getCallback(function() {
                helper.closeListbox(component, "searchLookup"+searchString)
            }), 250
        );
        //helper.displayPredictions(component, searchString);
    },
    selectOption: function(component, event,helper){
        var value = event.getSource().get("v.name");
        var searchString= value.split("_");
        var selection  = event.getSource().get("v.name");
        var value  = event.getSource().get("v.label");
        var path = "input"+selection.split('_')[1];
        component.find(path).set("v.value",value);
        console.log("input"+path);
        helper.closeListbox(component, "searchLookup"+searchString[1]);
    },
    getValueFromLwc : function(component, event, helper) {
        console.log('VS getValueFromLwc: '+event.getParam('value'));        
        var str = event.getParam('value');
        var arr = component.get('v.hobbyBackup');
        var arr2 = component.get('v.newItem.Hobby__c');
        
        
        const set1 = new Set(arr);
        if(arr2 != undefined){
            if(arr2.includes(";")){
                var backup=arr2.split(";")
                for(var i=0; i<backup.length;i++)
                set1.add(backup[i]);
            }else if(arr2.length>0 && !arr2.includes(";")){
                set1.add(arr2);
            }
        }
        
        
        if(str.startsWith("r_")){
            str = str.replace('r_',"")
            set1.delete(str);
        }        
        else{
            set1.add(str);
        }
        var arrFin= Array.from(set1);
        var strFin =arrFin.join(";");
        console.log(strFin);
        component.set('v.hobbyBackup',arrFin);
        component.set('v.newItem.Hobby__c',strFin);
	},
    
    handleComponentEvent : function (component,event,helper){
        var message = event.getParam("message");
        var payload = event.getParam("payload");
        if (message == 'showDCC'){
            component.set("v.DCCBool",true);
        } else if (message == 'makeCallout'){
            helper.makeCalloutWithTaxFreeInfo(component,event,payload);
        }
    }
})