public  with sharing class PanelListViewAPEXController{
@AuraEnabled
 public static List<Panel__c> doSearch(string nameOrId){
        String searchStr = '%' + nameOrId + '%';
        return [SELECT Id, Name, Associate__c, Curriculum__c, Panelist__c, Panel_Round__c FROM Panel__c Where Name LIKE :searchStr];
    }
}