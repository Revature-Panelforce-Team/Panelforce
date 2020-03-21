public with sharing class TechDetails {
    @auraenabled 
    public static List<Technology__c> alltech(){
        return [select name,Weight_in_Panel_Results__c from technology__c];
    }
    
    /*@auraenabled 
public static List<Technology__c> getCurriculumTechs(string curriculumId){

return [select name, Curriculum__c, Weight_in_Panel_Results__c from technology__c where Curriculum__c = :curriculumId];
}*/
    
    @auraenabled 
    public static list<Panel_Results__c> getCurriculumTechs(string curriculumId, string panelId){
        
        //send back a list of PanelResults objects that have the fields Grade, panelid, and techid
        list<Technology__c> techList = new list<Technology__c>();
        techList = [select name, Curriculum__c from technology__c where Curriculum__c = :curriculumId];
        integer techCount = [select count() 
                             from technology__c 
                             where Curriculum__c = :curriculumId];
        
        list<Panel_Results__c> panels = new list<Panel_Results__c>();
        
        for(integer i=0;i<techCount;i++){
            Panel_Results__c panelTechs = new Panel_Results__c();
            panelTechs.Technology__c = techlist[i].id;
            panelTechs.Panel__c = panelId;
            panelTechs.Grade__c = 00 ;
            panels.add(panelTechs);
        }
        
        insert panels;
        return panels;
    }
    
    @auraenabled
    //create a panel and send back the record ID
    public static id startPanel(string sentPanelName){
        Panel__c newPanel = new Panel__c();
        newPanel.name = sentPanelName;
        insert newPanel;
        return newPanel.id;
    }
    
    @auraenabled
    public static void submitPanel(list<Panel_Results__c> panelTech, list<string> gradeList){
        
        system.debug(panelTech);
        system.debug(gradeList);
        
        for(integer i = 0; i<panelTech.size(); i++){
            integer gradeInt = integer.valueOf(gradeList[i]);
            panelTech[i].Grade__c = gradeInt;
        }
        
        system.debug(panelTech);
        
        update panelTech;

    }
    
}