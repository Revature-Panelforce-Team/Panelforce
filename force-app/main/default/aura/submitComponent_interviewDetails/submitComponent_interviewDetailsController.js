({
    onInit : function(component, event, helper)
    {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.currUser",userId);
    },
    submitForm : function(component, event, helper)
    {
        component.find("recordEditForm").submit();
    },
    
    handlePassPanelId : function(component, event, helper)
    {
        var panelId = event.getParam("panelIdFromParent");
        component.set("v.panelId", panelId);        
    },
    
    populateGrades : function(component, event, helper)
    {
        var curriculumID = component.find("Curriculum").get("v.value");
        component.set("v.currCurriculum",curriculumID);
        var CurrIdTransfer = $A.get("e.c:SubmitPanelCompPassCurrID");
        CurrIdTransfer.setParams({
            "currCurriculumId" : curriculumID
        })
        CurrIdTransfer.fire();
    }
    
})