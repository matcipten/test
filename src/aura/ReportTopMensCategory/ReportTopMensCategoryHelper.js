({

    createChart: function (component) {
        var ready = component.get("v.ready");
        if (ready === false) {
            return;
        }
        var chartCanvas;
        var action = component.get("c.getReport");
        component.set("v.showChart", true);
        action.setParams({
            "accId": component.get("v.recordId"),//component.get("v.recordId"), //'0013600000lkd6R'
            "reportName": 'Top_Men_s_Category'
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            var totNum = 0;
            if (state === "SUCCESS") {
                var reportResultData = JSON.parse(response.getReturnValue());
                console.log('VS response: '+response.getReturnValue());
                console.log(reportResultData);
                component.set("v.reportId", reportResultData.reportMetadata.id);

                var chartLabels = [];
                if (reportResultData.groupingsDown.groupings != null) {

                    var datasets0 = [];
                    var labels0 = [];
                    var wrap = [];
                    var labels1Map = new Map();
                    var dataColor = new Map();
                    var labels1 = [];
                  
                    
                    for (let i = 0; i < (reportResultData.groupingsDown.groupings.length); i++) {
                        let labelTemp = reportResultData.groupingsDown.groupings[i].label;
                        labels0[i] = labelTemp;

                        let externalGroup = reportResultData.groupingsDown.groupings[i];
                        console.log('VS  externalGroup.groupings: '+ JSON.stringify(externalGroup.groupings));
                        for (let j = 0; j < externalGroup.groupings.length; j++) {
                            var wr =  [];
                            wr.outerLabel = labelTemp
                            wr.innerLabel = externalGroup.groupings[j].label;
                            wr.size= externalGroup.groupings[j].groupings;
                            var keyTemp = externalGroup.groupings[j].key;
                            var valueTemp = Math.round(reportResultData.factMap[keyTemp + '!T'].aggregates[0].value);
                            //wr.value =  valueTemp;
                            wr.value = [];
                            wr.size.forEach((item) => {
                                wr.value.push(Math.round(reportResultData.factMap[item.key + '!T'].aggregates[0].value));
                            });
                            wrap.push(wr);
                            
                            labels1Map.set(externalGroup.groupings[j].label, externalGroup.groupings[j].label);
                            
                            
                            
                        }
                    }
                    console.log(labels0);
                    console.log('****');
                    console.log(JSON.stringify(wrap));
                    component.set("v.wrapLabelsList",labels0);
                    component.set("v.wrapList",wrap);
                    
              
                } else {

                    component.set("v.showChart", false);
                }

            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message on createReport: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);

    },

    transpose: function(component,event,a){
        return Object.keys(a[0]).map(function(c) {
            return a.map(function(r) { return r[c]; });
        });
    }

})