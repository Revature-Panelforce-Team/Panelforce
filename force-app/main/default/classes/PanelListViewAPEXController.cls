public  with sharing class PanelListViewAPEXController{
	@AuraEnabled
	public static List<Panel__c> doSearch(string nameOrId){
        List<Panel__c> results = new List<Panel__c>();
        try{
            results = [SELECT Id, Name, Associate__c, Curriculum__c, Panelist__c, Panel_Round__c FROM Panel__c Where Id = :nameOrId];
        }
        finally{
            if(results.isEmpty()){
                String searchStr = '%' + nameOrId + '%';
        		results =  [SELECT Id, Name, Associate__c, Curriculum__c, Panelist__c, Panel_Round__c FROM Panel__c Where Name LIKE :searchStr];
            }
        }
        return results;
    }
}