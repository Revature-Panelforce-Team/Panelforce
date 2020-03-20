public with sharing class PanelViewAPEXController {
    @AuraEnabled
    public static List<Panel_Results__c> getPanelResults(string panelId){
        return [SELECT Id, Technology__r.Name, Technology__r.Weight_in_Panel_Results__c, Grade__c  FROM Panel_Results__c WHERE Panel__c = :panelId];
    }
}