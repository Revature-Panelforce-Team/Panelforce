({
	  initPanelRecordList : function(component,event, helper) {
var action = component.get("c.getPanelResults");
        action.setParams({panelId : component.get("v.panelId")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                // Flattening the data because datatables can't handle parent data from queries
                var rows = response.getReturnValue();
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    row.Technology__rName = row.Technology__r.Name;
                    row.Technology__rWeight_in_Panel_Results__c = row.Technology__r.Weight_in_Panel_Results__c;
                }
                component.set('v.panelRecords', rows);
                console.log(rows);
            }
         });
         $A.enqueueAction(action);
}
})