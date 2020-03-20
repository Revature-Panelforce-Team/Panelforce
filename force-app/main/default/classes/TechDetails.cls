public with sharing class TechDetails {
    @auraenabled 
    public static List<Technology__c> alltech(){
        return [select name,Weight_in_Panel_Results__c from technology__c];
    }
    
    @auraenabled 
    public static List<Technology__c> getCurriculumTechs(string curriculumId){
        return [select name, Curriculum__c, Weight_in_Panel_Results__c from technology__c where Curriculum__c = :curriculumId];
    }
    
    @auraenabled
    public static void insertGrades(list<string> gradesList){

        
        
    }
}