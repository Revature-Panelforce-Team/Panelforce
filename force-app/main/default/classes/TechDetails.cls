public with sharing class TechDetails {
 @auraenabled 
    public static List<Technology__c> alltech(){
        
        return [select name,Weight_in_Panel_Results__c from technology__c];
    }
}