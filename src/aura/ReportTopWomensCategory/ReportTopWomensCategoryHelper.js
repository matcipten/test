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
            "accId": component.get("v.recordId"),//component.get("v.recordId"), //'0013600000lkd6N'
            "reportName": 'Top_Women_s_Category'
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            var totNum = 0;
            if (state === "SUCCESS") {
                var reportResultData = JSON.parse(response.getReturnValue());
                console.log(reportResultData);
                component.set("v.reportId", reportResultData.reportMetadata.id);

                var chartLabels = [];
                if (reportResultData.groupingsDown.groupings != null) {
                   // chartCanvas = component.find("chartReport").getElement().getContext("2d");

                    var datasets0 = [];
                    var labels0 = [];
                    var wrap = [];
                    var labels1Map = new Map();
                    var dataColor = new Map();
                    var labels1 = [];
                    var bcscolor = [
                        "#1589ee",
                        "#00396b",
                        "#79DFD9",
                        "#09A5A1",
                        "#D4C76B",
                        "#F8C64B",
                        "#4EC540",
						"#BB7742",
						"#BF5849",
						"#B5D262",
						"#F6E107",
						"#B63CE9",
						"#ff80bf",
						"#e6ccff",
						"#bfff80",
						"#ffdd99",
						"#ff9999",
						"#26004d",
						"#ffff80",
						"#b3ffff",
						"#b3d9ff",
						"#df9fbf",
						"#ccfff5",
						"#ecc6c6",
						"#ffccb3"
                    ];
                    var count = 0;
                    
                    for (let i = 0; i < (reportResultData.groupingsDown.groupings.length); i++) {
                        let labelTemp = reportResultData.groupingsDown.groupings[i].label;
                        labels0[i] = labelTemp;

                        let externalGroup = reportResultData.groupingsDown.groupings[i];
                        console.log('VS  externalGroup.groupings: '+ JSON.stringify(externalGroup.groupings));
                        for (let j = 0; j < externalGroup.groupings.length; j++) {
                            var wr =  [];
                            wr.outerLabel = labelTemp
                            wr.innerLabel = externalGroup.groupings[j].label;
                            wr.size = externalGroup.groupings[j].groupings;
                            var keyTemp = externalGroup.groupings[j].key;
                            var valueTemp = Math.round(reportResultData.factMap[keyTemp + '!T'].aggregates[0].value);
                            console.log('reportResultData.factMap: '+JSON.stringify(reportResultData.factMap[keyTemp + '!T']));
                            console.log('valueTemp: '+valueTemp);
                            //wr.value =  valueTemp;
                            wr.value = [];
                            wr.size.forEach((item) => {
                                wr.value.push(Math.round(reportResultData.factMap[item.key + '!T'].aggregates[0].value));
                            });
                            wrap.push(wr);
                            
                            labels1Map.set(externalGroup.groupings[j].label, externalGroup.groupings[j].label);
                            
                            if(!dataColor.has(externalGroup.groupings[j].label)){
                                dataColor.set(externalGroup.groupings[j].label, bcscolor[count]);
                                count ++ ;
                            }
                            
                        }
                    }
                    console.log(labels0);
                    console.log('****AAAA');
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

    
})