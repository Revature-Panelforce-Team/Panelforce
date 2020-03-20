({
    //Populate the Technology Fields
    handleIdPass : function(component, event, helper) {
        var currId = event.getParam("currCurriculumId");
        var action = component.get("c.getCurriculumTechs");
        action.setParams({curriculumId : currId});
        action.setCallback(this, function(response){
            component.set("{!v.tech}",response.getReturnValue());
        })
        $A.enqueueAction(action);
    },
    
    testMethod : function(component, event, helper) {
        
        var grades = component.find("gradeList").getElement();
        console.log(grades);
        
    }
})