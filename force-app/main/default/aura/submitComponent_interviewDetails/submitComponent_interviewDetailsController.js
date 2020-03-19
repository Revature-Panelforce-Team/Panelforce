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
    populateGrades : function(component, event, helper)
    	{
            var curriculumID = component.find("Curriculum").get("v.value");
            component.set("v.currCurriculum",curriculumID);
        }
    
})