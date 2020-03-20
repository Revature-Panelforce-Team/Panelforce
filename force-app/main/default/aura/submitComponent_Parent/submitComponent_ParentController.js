({
	submitEvent : function(component, event, helper) {
        var submitPanel = $A.get("e.c:submitComponent_submitPanelRecord");
        submitPanel.fire();
	}
})