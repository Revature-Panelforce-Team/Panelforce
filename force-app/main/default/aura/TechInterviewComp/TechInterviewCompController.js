({
	techlist : function(component, event, helper) {
		   
        var action = component.get("c.alltech");
        action.setCallback(this,function(a){
            console.log(a.getReturnValue());  
            component.set("{!v.tech}",a.getReturnValue());
            
            
        });
        $A.enqueueAction(action);
	}
})