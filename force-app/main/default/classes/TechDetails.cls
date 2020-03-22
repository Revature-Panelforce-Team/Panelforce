public with sharing class TechDetails {
    
    //For Populating panel technology component
    @auraenabled 
    public static List<Technology__c> getCurriculumTechs(string curriculumId){
        list<Technology__c> results = [select name, Curriculum__c, Weight_in_Panel_Results__c from technology__c where Curriculum__c = :curriculumId];
		system.debug(results);
        return results;
    }
    
    @auraenabled
    //create a panel and send back the record ID
    public static id startPanel(string sentPanelName){
        Panel__c newPanel = new Panel__c();
        newPanel.name = sentPanelName;
        insert newPanel;
        return newPanel.id;
    }
    
    //Submit Panel Results
    @auraenabled
    public static void submitPanel(list<Technology__c> panelTech, list<string> gradeList, string panelId, list<string> commentList, list<boolean> repanelList){
        
        system.debug(repanelList);
                                       
        //create the panel_results_list
        list<Panel_Results__c> panelResultsList = new list<Panel_Results__c>();
                                       
        //Populate the panel results list with inputs from component
        for(integer i=0;i<panelTech.size();i++){
            Panel_Results__c panelTechResult = new Panel_Results__c();
            panelTechResult.Technology__c = panelTech[i].id;
            panelTechResult.Comment__c = commentList[i];
            panelTechResult.Repanel__c = repanelList[i];
            panelTechResult.Panel__c = panelId;
            integer gradeInt = integer.valueOf(gradeList[i]);
            panelTechResult.Grade__c = gradeInt;
            panelResultsList.add(panelTechResult);
        }
        
        insert panelResultsList;
        
    }
    
}