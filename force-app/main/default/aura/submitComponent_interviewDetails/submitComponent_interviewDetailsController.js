({
	onInit : function(component, event, helper)
        {
            var userId = $A.get("$SObjectType.CurrentUser.Id");
            component.set("v.currUser",userId);
        },
    submitForm : function(component, event, helper)
    	{
            var form = component.find("recordEditForm");
            form.submit();
        },
    handleSuccess : function(component, event, helper)
    	{
            var panel = event.getParams().response;
            console.log(panel.id); // Do more by passing this as an input to a method to insert grades
		},
    
     selfHandle : function(component, event, helper)
    	{
         	console.log("youve entered selfHandle");
            var currId = event.getParam("currCurriculumId");
            console.log(currId);

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