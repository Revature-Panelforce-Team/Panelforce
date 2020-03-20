({
	onInit : function(component, event, helper)
        {
            var userId = $A.get("$SObjectType.CurrentUser.Id");
            component.set("v.currUser",userId);
        },
    submitForm : function(component, event, helper)
    	{
            console.log("you have entered submitForm");
            component.find("recordEditForm").submit();
        },
    handleSuccess : function(component, event, helper)
    	{
            var panel = event.getParams().response;
            console.log(panel.id); // Do more by passing this as an input to a method to insert grades
            component.set("v.panelId", panel.id);
            console.log(component.get("v.panelId"));
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