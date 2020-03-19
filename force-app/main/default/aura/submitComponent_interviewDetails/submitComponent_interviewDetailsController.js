({
    // Set User
    onInit : function(component, event, helper)
        {
            var userId = $A.get("$SObjectType.CurrentUser.Id");
            component.set("v.currUser",userId);
        },
    // This is to show you can use javascript to submit a form.
    buttonMimic : function(component, event, helper)
    	{
            /*var whichOne = event.getSource().getLocalId();
            console.log(whichOne);*/
            var form = component.find("recordEditForm");
            form.submit();
            var payload = event.getParams().response;
            console.log(payload.id); // This is the Panel__c ID
        },
    // This will submit grades after panel is successfully submitted.
    handleSuccess : function(component, event, helper)
    	{
            var payload = event.getParams().response;
            console.log(payload.id); // Do more by passing this as an input to a method to insert grades
		},
    // This creates the Panel Results records
    populateGrades : function(component, event, helper)
    	{
            var stringer = component.find("Curriculum").get("v.value");
            component.set("v.currCurriculum",stringer);
        }
    
})