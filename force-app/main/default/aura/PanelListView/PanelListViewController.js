({
    handleSearchNameID : function(component, event, helper) {
		/*the search querry is handle by the helper controller 
		 * hence handleSearchNameID method just invoke the helper controller */ 
        helper.findNameOrID(component, event, helper);
    },
    handleRowAction: function(component, event, helper) {
        debugger;
       
         var action = event.getParam('action');
        var recordDetail =event.getParam('row');
        
        
        console.log(recordDetail.Id)
        if(action.name=='show_details'){
            
            component.set("v.PassRecordID",recordDetail.Id);
            component.set("v.ShowRecordDetails",True);
        }
            else
                component.set("v.ShowRecordDetails",False);
        
    }   
})