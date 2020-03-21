({
    beginPanel : function(component, event, helper) {
        var beginPanelAction = component.get("c.startPanel");
        var passPanelIdEvt = $A.get("e.c:submitComponent_passPanelId");

        beginPanelAction.setParams({sentPanelName : component.get("v.panelName")})
        beginPanelAction.setCallback(this, function(response){
            console.log(response.getReturnValue());
            passPanelIdEvt.setParams({"panelIdFromParent" : response.getReturnValue()})
            passPanelIdEvt.fire();        
        })
        
        $A.enqueueAction(beginPanelAction);
    },
    
    submitEvent : function(component, event, helper) {
        var submitPanel = $A.get("e.c:submitComponent_submitPanelRecord");
        submitPanel.fire();
    }
})