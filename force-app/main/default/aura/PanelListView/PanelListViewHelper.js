({ 
    // this helper controller handles the search querry(business logic)
       findNameOrID : function(component, event, helper) {
           //variable to store the result from the Apex auraEnabled method 'doSearch'
	var action = component.get("c.doSearch");
       //variable to store the name or Id from the component textbox which the user is searching
    var searchInput = component.get("v.searchName");
       //passing the parameter to the apex method    
        action.setParams({nameOrId:searchInput});
        action.setCallback(this,function(a){
            console.log(a.getReturnValue());  
            component.set("v.searchResults",a.getReturnValue());});
           $A.enqueueAction(action);
        
    }
})