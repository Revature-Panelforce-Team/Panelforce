({
    //Populate the Technology Fields
    handleIdPass : function(component, event, helper) {
        var currId = event.getParam("currCurriculumId");
        component.set("v.curriculumId", currId);
        var action = component.get("c.getCurriculumTechs");
        action.setParams({
            curriculumId : currId,
        });
        action.setCallback(this, function(response){
            component.set("{!v.panelTechs}",response.getReturnValue());
            console.log(component.get("v.panelTechs"));
        })
        $A.enqueueAction(action);
    },
    
    handlePanelIdPass : function(component, event, helper) {
        var panelId = event.getParam("panelIdFromParent");
        component.set("v.panelId", panelId);
    },
    
    updateGradeList : function(component,event,helper){
        var gradeList = component.get("v.techGradeList"); //Get the grade array from component
        gradeList[event.getSource().get('v.name')] = event.getSource().get('v.value'); //Update the values in the array based on index and value
        console.log(component.get("v.techGradeList"));
    },
    
    handleSubmit : function(component, event, helper){
        
        var action = component.get("c.submitPanel"); //send paneltech list and techgrade list to apex
        action.setParams({
            panelTech : component.get("v.panelTechs"),
            gradeList : component.get("v.techGradeList"),
            panelId : component.get("v.panelId")
        })
        
        $A.enqueueAction(action);
    }
        
    })