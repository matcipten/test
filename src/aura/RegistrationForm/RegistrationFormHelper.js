({
    fetchPickListVal: function (component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.newItem"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                //console.log(allValues);
                opts.push({
                    class: "optionClass",
                    label: "",
                    value: ""
                });

                for (var k in allValues) {
                    //console.log(JSON.stringify(allValues));
                    opts.push({
                        class: "optionClass",
                        label: k,
                        value: allValues[k]
                    });
                }
                
                 if (elementId == 'InputSelectDynamicCountry'){
                     console.log(opts);
                     var defaultIndex = opts.findIndex(function(opts){return opts.value === component.get("v.user.Nation_Contact_Card__c")});
                     
                     //opts.unshift({class: "optionClass", label: opts[defaultIndex].label, value: opts[defaultIndex].value});
                     component.find(elementId).set("v.options", opts);
                     setTimeout(
                         $A.getCallback(
                             function() {
                                 if (component.find(elementId).get("v.value")=='undefined' || component.find(elementId).get("v.value")=='' || component.find(elementId).get("v.value")==undefined)
                                 	component.find(elementId).set("v.value", opts[defaultIndex].value);
                             }
                         )
                     );
                     
                	}
                else
                	component.find(elementId).set("v.options", opts);
               
               
            }
        });
        $A.enqueueAction(action);
    },
	//SALESFORCE-657 ->
    checkNotAnsiChars: function (str) {
      var patt = new RegExp("^[a-z A-Z !\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\\\]\^\_\`\{\|\}\~\\¡\¢\£\¤\¥\¦\§\¨\©\ª\«\¬\­\®\¯\°\±\²\³\´\µ\¶\·\¸\¹\º\»\¼\½\¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿŒœŠšŸŽžƒˆ˜–—‘’‚“”„†‡•…‰‹›€™ ]*$");
      var res = patt.test(str);
      return res;
    },
	//SALESFORCE-657 <-
    fetchPickListCountryVal: function (component, fieldName, elementId) {

        //  console.log('fetchPickListCountryVal');

        var opts = [];

        opts.push({
            class: "optionClass",
            label: "",
            value: ""
        });

        var allValues = ['Aaland Islands', 'Afghanistan', 'Albania', 'Algeria', 'American Samoa', 'Andorra', 'Angola', 'Anguilla', 'Antarctica', 'Antigua And Barbuda', 'Argentina', 'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bermuda', 'Bhutan', 'Bolivia', 'Bosnia And Herzegowina', 'Botswana', 'Bouvet Island', 'Brazil', 'British Indian Ocean Territory', 'Brunei Darussalam', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Cape Verde', 'Cayman Islands', 'Central African Republic', 'Chad', 'Chile', 'China', 'Christmas Island', 'Cocos (Keeling) Islands', 'Colombia', 'Comoros', 'Congo, Democratic Republic Of (Was Zaire)', 'Congo, Republic Of', 'Cook Islands', 'Costa Rica', 'Cote D\'Ivoire', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Ethiopia', 'Falkland Islands (Malvinas)', 'Faroe Islands', 'Fiji', 'Finland', 'France', 'French Guiana', 'French Polynesia', 'French Southern Territories', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Gibraltar', 'Greece', 'Greenland', 'Grenada', 'Guadeloupe', 'Guam', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Heard And Mc Donald Islands', 'Honduras', 'Hong Kong', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran (Islamic Republic Of)', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Korea, Democratic People\S Republic Of', 'Korea, Republic Of', 'Kuwait', 'Kyrgyzstan', 'Lao People\S Democratic Republic', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libyan Arab Jamahiriya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macau', 'Macedonia, The Former Yugoslav Republic Of', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Martinique', 'Mauritania', 'Mauritius', 'Mayotte', 'Mexico', 'Micronesia, Federated States Of', 'Moldova, Republic Of', 'Monaco', 'Mongolia', 'Montserrat', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'Netherlands Antilles', 'New Caledonia', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Norfolk Island', 'Northern Mariana Islands', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Palestinian Territory, Occupied', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Pitcairn', 'Poland', 'Portugal', 'Puerto Rico', 'Qatar', 'Reunion', 'Romania', 'Russian Federation', 'Rwanda', 'Saint Helena', 'Saint Kitts And Nevis', 'Saint Lucia', 'Saint Pierre And Miquelon', 'Saint Vincent And The Grenadines', 'Samoa', 'San Marino', 'Sao Tome And Principe', 'Saudi Arabia', 'Senegal', 'Serbia And Montenegro', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Georgia And The South Sandwich Islands', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Svalbard And Jan Mayen Islands', 'Swaziland', 'Sweden', 'Switzerland', 'Syrian Arab Republic', 'Taiwan', 'Tajikistan', 'Tanzania, United Republic Of', 'Thailand', 'Timor-Leste', 'Togo', 'Tokelau', 'Tonga', 'Trinidad And Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Turks And Caicos Islands', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States', 'United States Minor Outlying Islands', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City State (Holy See)', 'Venezuela', 'Viet Nam', 'Virgin Islands (British)', 'Virgin Islands (U.S.)', 'Wallis And Futuna Islands', 'Western Sahara', 'Yemen', 'Zambia', 'Zimbabwe'];

        var allValuesIso = ['AX', 'AF', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AQ', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', 'BZ', 'BJ', 'BM', 'BT', 'BO', 'BA', 'BW', 'BV', 'BR', 'IO', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', 'CN', 'CX', 'CC', 'CO', 'KM', 'CD', 'CG', 'CK', 'CR', 'CI', 'HR', 'CU', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', 'ET', 'FK', 'FO', 'FJ', 'FI', 'FR', 'GF', 'PF', 'TF', 'GA', 'GM', 'GE', 'DE', 'GH', 'GI', 'GR', 'GL', 'GD', 'GP', 'GU', 'GT', 'GN', 'GW', 'GY', 'HT', 'HM', 'HN', 'HK', 'HU', 'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IL', 'IT', 'JM', 'JP', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KR', 'KW', 'KG', 'LA', 'LV', 'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MO', 'MK', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MQ', 'MR', 'MU', 'YT', 'MX', 'FM', 'MD', 'MC', 'MN', 'MS', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'AN', 'NC', 'NZ', 'NI', 'NE', 'NG', 'NU', 'NF', 'MP', 'NO', 'OM', 'PK', 'PW', 'PS', 'PA', 'PG', 'PY', 'PE', 'PH', 'PN', 'PL', 'PT', 'PR', 'QA', 'RE', 'RO', 'RU', 'RW', 'SH', 'KN', 'LC', 'PM', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'CS', 'SC', 'SL', 'SG', 'SK', 'SI', 'SB', 'SO', 'ZA', 'GS', 'ES', 'LK', 'SD', 'SR', 'SJ', 'SZ', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', 'TG', 'TK', 'TO', 'TT', 'TN', 'TR', 'TM', 'TC', 'TV', 'UG', 'UA', 'AE', 'GB', 'US', 'UM', 'UY', 'UZ', 'VU', 'VA', 'VE', 'VN', 'VG', 'VI', 'WF', 'EH', 'YE', 'ZM', 'ZW'];



        for (var i = 0; i < allValues.length; i++) {
            opts.push({
                class: "optionClass",
                label: allValues[i],
                value: allValuesIso[i]
            });
        }

        component.find(elementId).set("v.options", opts);
    },

    resizeCanvas: function (canvas, width) {
        var device = $A.get("$Browser.formFactor");
        if (device == 'DESKTOP') {
            if (width >= 1024) {
                canvas.width = width / 2;
            } else {
                canvas.width = width - 10;
            }
        } else {
            canvas.width = 550;
        }
        canvas.height = 200;

        var context = canvas.getContext('2d');

    },

    setTranslation: function (component) {
        var action = component.get("c.getUserInformation");
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var usr = response.getReturnValue();
                console.log(usr.Nation_Contact_Card__c);
                var locale = (usr.Nation_Contact_Card__c != null || usr.Nation_Contact_Card__c != undefined) ?  usr.Nation_Contact_Card__c : 'US' ;
                var prefer_language = usr.Language_Contact_Card__c;
                var action = component.get('c.getTranslatorForm');
                action.setParams({
                    "locale": locale
                });

                action.setCallback(this, function (response) {
                    if (response.getState() == "SUCCESS") {
                        var all_translation = new Object();
                        var multilanguage = false;

                        all_translation = JSON.parse(JSON.stringify(response.getReturnValue()));
                        console.log('********************************all_translation.length');
                        console.log(response.getReturnValue().length);
                        component.set("v.translator", all_translation);

                        var locale_lang = (prefer_language == null ) ? 'en' + '_' + locale.toUpperCase() : prefer_language.toLowerCase() + '_' + locale.toUpperCase();
                         console.log(locale_lang);
                        var all_key = Object.keys(all_translation);

                        //var container = [];
                        /*all_key.forEach(key => {
                            if (key.includes(locale)) {
                                container.push(key);
                            }
                        });*/
                        var optsLang = [];

                        //all_key.forEach(element => {
                        for(let i = 0 ; i < all_key.length ; i++){
                            var pick_lang = new Object();
                            pick_lang.class = 'optionClass';
                            pick_lang.label = all_key[i].split('_')[0];
                            pick_lang.value = all_key[i];
                            pick_lang.selected = (prefer_language == null) ? ('en'.localeCompare(all_key[i].split('_')[0]) == 0) ? 'true' : '' : (prefer_language.localeCompare(all_key[i].split('_')[0]) == 0) ? 'true' : '';
                            optsLang.push(pick_lang);
                        }
                        //});

                        if (optsLang.length <= 1) {
                            var picklistShow = component.find("picklistShow");
                            $A.util.addClass(picklistShow, "notShowPicklist");
                            $A.util.removeClass(picklistShow, "slds-grid");
                            $A.util.removeClass(picklistShow, "slds-wrap");
                        }

                        component.find("InputSelectDynamicLanguage").set("v.options", optsLang);

                        var usr_translation = new Object();
                        usr_translation = all_translation[locale_lang];

                        component.set("v.translatorValue", usr_translation);
                        component.set("v.multiLanguage", multilanguage);
                        component.set("v.language", locale_lang);
                        component.set("v.locale", locale_lang.split('_')[1]);
                        component.set("v.TranslationDCCVersion",usr_translation.Versione_DCC__c );
                        component.set("v.TranslationRichiediFirma",usr_translation.Richiedi_Firma__c );
                        // console.log(usr_translation);
						
                        if (usr_translation != null  && usr_translation.Profession_Values__c != null) {
                             this.setPicklist(component, 'Professione__c','InputSelectDynamicProfession',usr_translation.Profession_Values__c , false);
                        }
                        else{
                            this.orderPickLabels(component, 'Professione__c','InputSelectDynamicProfession');
                        }
                        if (usr_translation != null  && usr_translation.Hobby_Values__c != null) {
                            this.setPicklist(component, 'Hobby__c', 'InputSelectDynamicHobby', usr_translation.Hobby_Values__c, false);
                        }
                        else{
                            this.orderPickLabels(component, 'Hobby__c', 'InputSelectDynamicHobby');
                        }
                        /*if(usr_translation.Nationality_Values__c != null){
                            this.setPicklist(component, 'Nazionalita__c','InputSelectDynamicNationality',usr_translation.Nationality_Values__c , false);
                            this.setPicklist(component, 'Nazionalita__c', 'InputSelectDynamicCountry',usr_translation.Nationality_Values__c , false);
                            this.setPicklist(component, 'Nazionalita__c', 'InputSelectDynamicPassportCountry',usr_translation.Nationality_Values__c , false);
                        }*/
                        //MC- split date
                        var optsDay = [];
                        var optsMonth = [];
                        var optsYear = [];
                        //Days
                        optsDay.push({class: "optionClass firstSelectOption",label: "Day",value: "",selected: "selected"});
                        for(var i=1;i < 32;i++){
                            optsDay.push({class: "optionClass",label: i.toString(),value: i.toString()});
                        }
                        if (component.get("v.locale") == 'JP')
                            component.find("InputSelectDayJP").set("v.options",optsDay);
                        else
                            component.find("InputSelectDay").set("v.options",optsDay);
                        //Months
                        optsMonth.push({class: "optionClass firstSelectOption",label: "Month",value:"",selected: "selected"});
                        var months = [$A.get("$Label.c.January"),$A.get("$Label.c.February"),$A.get("$Label.c.March"),$A.get("$Label.c.April"),
                                        $A.get("$Label.c.May"),$A.get("$Label.c.June"),$A.get("$Label.c.July"),
                                        $A.get("$Label.c.August"),$A.get("$Label.c.September"),$A.get("$Label.c.October"),
                                        $A.get("$Label.c.November"),$A.get("$Label.c.December")];
                
                        for(var i = 0;i < 12;i++){
                            optsMonth.push({class: "optionClass firstSelectOption",label: months[i],value: (i+1).toString()});
                        }
                        if (component.get("v.locale") == 'JP')
                        	component.find("InputSelectMonthJP").set("v.options",optsMonth);
                        else
                            component.find("InputSelectMonth").set("v.options",optsMonth);
                        //Years
                        optsYear.push({class: "optionClass firstSelectOption",label: "Year",value: "",selected: "selected"}); 
                        for(var i = 1940;i <= (new Date()).getFullYear();i++){
                            optsYear.push({class: "optionClass",label: i.toString(),value: i.toString()});
                           // optsYear.push({class: "optionClass",label: i,value: i});
                        }
                        if (component.get("v.locale") == 'JP')
                            component.find("InputSelectYearJP").set("v.options",optsYear);
                        else
                            component.find("InputSelectYear").set("v.options",optsYear);
                        var spinner = component.find("mySpinner");
                        $A.util.addClass(spinner, "slds-hide");
                    }
                });
                $A.enqueueAction(action);

            }
        });
        $A.enqueueAction(action);

    }, 

    orderPickLabels: function(component, fieldName, elementId){
        var opts = component.find(elementId).get("v.options");
        var value = component.get("v.newItem." + fieldName);
        console.log('opt222');
        console.log(opts);
        opts.sort(function(a, b) { 
            return a.label < b.label ? -1 : 1;
        });
        
        console.log(opts);

        component.find(elementId).set("v.options", opts);
        if (value != null && value != '')
            component.set("v.newItem." + fieldName, value);
    },

    setPicklist: function (component, fieldName, elementId, fieldValues, bool) {
        var value = component.get("v.newItem." + fieldName);
        var opts = [];
        var optsTemp = [];
        var splitField = fieldValues.split('|');
        var options = component.find(elementId).get("v.options");
       
      
        for (var x in options) {
            if(options[x].label != '' && options[x].value != ''){
                optsTemp.push({
                    class: "optionClass",
                    label: options[x].label,
                    value: options[x].value
                });
    

            }
            
        }
        
        
        //compilare nuovo lista con label e value vuoto
        opts.push({
            class: "optionClass",
            label: "",
            value: ""
        });

        if (optsTemp.length == splitField.length) {
            //component.find(elementId).set("v.options", opts);
            for (var k in optsTemp) {

                opts.push({
                    class: "optionClass",
                    label: splitField[k],
                    value: optsTemp[k].value
                });

               
            }
           
        }
        else{
            opts = options;
        }
         // console.log(opts);
             //PN 20190304
             opts.sort(function(a, b) { 
                return a.label < b.label ? -1 : 1;
            });
            
            console.log(opts);

            component.find(elementId).set("v.options", opts);

        if (value != null && value != '')
            component.set("v.newItem." + fieldName, value);
    },
    //Akshay 05/06/2019 Start
    setPicklist1: function (component, fieldName, elementId, fieldValues, bool) {
       
        var value = component.get("v.newItem." + fieldName);
        var opts = [];
        var optsTemp = [];
        var splitField = fieldValues.split('|');
       
       	var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.newAcc"),
            "fld": fieldName
        });
        var options = [];
          action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
             
                 var allValues = response.getReturnValue();
                //console.log(allValues);
                options.push({
                    class: "optionClass",
                    label: "",
                    value: ""
                });

                for (var k in allValues) {
                    //console.log(JSON.stringify(allValues));
                    options.push({
                        class: "optionClass",
                        label: k,
                        value: allValues[k]
                    });
                }
                
                //var options = component.find(elementId).get("v.options");
                for (var x in options) {
            console.log(options[x].label + ' && ' +options[x].value);
            if(options[x].label != '' && options[x].value != ''){
                optsTemp.push({
                    class: "optionClass",
                    label: options[x].label,
                    value: options[x].value
                });
    

            }
            
        }
        
        
        //compilare nuovo lista con label e value vuoto
        opts.push({
            class: "optionClass",
            label: "",
            value: ""
        });

        if (optsTemp.length == splitField.length) {
            //component.find(elementId).set("v.options", opts);
            for (var k in optsTemp) {

                opts.push({
                    class: "optionClass",
                    label: splitField[k],
                    value: optsTemp[k].value
                });

               
            }
           
        }
        else{
            opts = options;
        }
        
             opts.sort(function(a, b) { 
                return a.label < b.label ? -1 : 1;
            });
            
            console.log(opts);

            component.find(elementId).set("v.options", opts);

        if (value != null && value != '')
            component.set("v.newItem." + fieldName, value);

            }
            else if (state === "INCOMPLETE") {
               
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
     
        
    },
	//Akshay 05/06/2019  finish 

    setTranslationInPicklist: function (component) {
        var language = component.get("v.language");
        // console.log(language);
        var all_translation = component.get("v.translator");
        var usr_translation = new Object();
        usr_translation = all_translation[language];

        if (usr_translation.Profession_Values__c != null) {
            this.setPicklist1(component, 'Professione__c', 'InputSelectDynamicProfession', usr_translation.Profession_Values__c, true);
        }
        if (usr_translation.Hobby_Values__c != null) {
            this.setPicklist1(component, 'Hobby__c', 'InputSelectDynamicHobby', usr_translation.Hobby_Values__c, true);
        }

        component.set("v.translatorValue", usr_translation);

    },

    getAccountFields: function (component, id) {
        console.log('ID: ' + id);

        var action = component.get("c.getAccount");
        action.setParams({
            "AccountId": id
        });
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var acc = response.getReturnValue();
                // reset privacy
                /*acc.Privacy1__c = null;
                acc.Privacy2__c = null;
                acc.Privacy3__c = null;*/
                //  console.log(JSON.stringify(acc));
                component.set("v.newItem", acc);
                console.log("MC-getAccount 0 --> acc.Id: " + acc.Id + " - (acc.hasOwnProperty(Id): " + acc.hasOwnProperty("Id"));
                if (acc.hasOwnProperty("Id")) {
                    console.log("MC-getAccount 1");
                    component.set("v.isUpdate", true);
                    component.set("v.Privacy_1_old",acc.Privacy1__c);
                    component.set("v.Privacy_2_old",acc.Privacy2__c);
                    component.set("v.Privacy_3_old",acc.Privacy3__c);
                    component.set("v.DCCVersion_old",acc.Versione_DCC__c);
					component.set("v.DCC",acc.DCC__c);

                    //MC-start Get Birthdate and split on three fields
                    if(acc.PersonBirthdate != '' && acc.PersonBirthdate != null){
                        console.log("MC-getAccount 2");
                        var birthdate = new Date(acc.PersonBirthdate);
                        console.log("MC-getAccount 3 birthdate; " + birthdate);
                        component.set("v.dayBirthdate",(birthdate.getDate()).toString());
                        component.set("v.monthBirthdate",(birthdate.getMonth() + 1).toString());
                        component.set("v.yearBirthdate",(birthdate.getFullYear() == 2038) ? "" : (birthdate.getFullYear()).toString());
                    }
                    //MC-End
                } else {
                    component.set("v.isUpdate", false);
                    //component.set("v.newItem", null);
                }


            }

        });
        $A.enqueueAction(action);

    },

    isCanvasTransparent: function (canvas) { // true if all pixels Alpha equals to zero
        var ctx = canvas.getContext("2d");
        var imageData = ctx.getImageData(0, 0, canvas.offsetWidth, canvas.offsetHeight);
        for (var i = 0; i < imageData.data.length; i += 4)
            if (imageData.data[i + 3] !== 0) return false;

        return true;
    },

    getUserInfo: function (component) {
        var action = component.get("c.getUserInformation");
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var usr = response.getReturnValue();
                //  console.log(usr);
                component.set("v.user", usr);
                var locale = (usr.Nation_Contact_Card__c != null || usr.Nation_Contact_Card__c != undefined) ?  usr.Nation_Contact_Card__c : 'US' ;
                component.set("v.locale",locale);
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
    //MC-
    isLeapYear: function (year) {
        console.log("isLeapYear: " + ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
        return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
    },

    isValidDay: function (day,month,year) {
        var result = true;
        var mapDaysMonth = new Map();
        mapDaysMonth.set(1,31);
        mapDaysMonth.set(2,29);
        mapDaysMonth.set(3,31);
        mapDaysMonth.set(4,30);
        mapDaysMonth.set(5,31);
        mapDaysMonth.set(6,30);
        mapDaysMonth.set(7,31);
        mapDaysMonth.set(8,31);
        mapDaysMonth.set(9,30);
        mapDaysMonth.set(10,31);
        mapDaysMonth.set(11,30);
        mapDaysMonth.set(12,31);
        console.log("isValidDay --> Day: " + day + " -- Month: " + month + " -- Year: " + year);
        console.log("isValidDay --> (year != null && year != '' && !isNaN) --> " + (year != null && year != '' && !isNaN(year)));
        if(year != null && year != '' && !isNaN(year)) {
            if(!this.isLeapYear(year)){
                mapDaysMonth.set(2,28);
            }
            if(mapDaysMonth.has(month)){
                if(day > mapDaysMonth.get(month)){
                    result = false;
                }
            }else {result = false;}
        }else {
            if(mapDaysMonth.has(month)){
                if(day > mapDaysMonth.get(month)){
                    result = false;
                }
            }else {result = false;}
        }
        return result;    
    },

    isDayInRange: function (day) {
        return (day > 0 && day < 32);
    },

    isMonthInRange: function (month) {
        return (month > 0 && month < 13);
    }


})