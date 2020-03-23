@isTest
public class TestTechDetails {

    @isTest
    public static void testGetCurriculumTechs() {
        
        //Negative test, curriculum does not exist
        List<Technology__c> techList = TechDetails.getCurriculumTechs('not an id'); 
        System.assertEquals(0, techList.Size());
        
        //Insert test data, a curriculum and related technologies
        //First create a curriculum and insert to get an id 
        Curriculum__c curriculum = new Curriculum__c();
        curriculum.name = 'Salesforce';       
        insert curriculum;
        
		//Create a technology and relate it to the curriculum
		Technology__c technology = new Technology__c();
        technology.Name = 'Apex';
        technology.Weight_in_Panel_Results__c = 50;
        technology.Curriculum__c = curriculum.id;
        insert technology;        
        
        //Positive test
        techList = TechDetails.getCurriculumTechs(String.valueOf(curriculum.id));
        System.assertEquals(1, techList.Size());
        
    }
    
    @isTest
    public static void testStartPanelandPanelSubmit(){
        
        //Test if a panel object is inserted
        String panelId = TechDetails.startPanel('Test Panel');
        Panel__c panel = [SELECT Name FROM Panel__c WHERE Id = :panelId];
        System.assertEquals(Schema.Panel__c.SObjectType, panel.getSobjectType());        
        
        //Insert test data, a curriculum and related technologies
        //First create a curriculum and insert to get an id 
        Curriculum__c curriculum = new Curriculum__c();
        curriculum.name = 'Salesforce';       
        insert curriculum;
        
        //Create a list of technologies, relate them to curriculum then insert
        List<Technology__c> techList = new List<Technology__c>();
        for(Integer i=1;i<=4;i++){
            Technology__c technology = new Technology__c();
            technology.Name = 'Technology ' + i;
            technology.Weight_in_Panel_Results__c = 25;
            technology.Curriculum__c = curriculum.id;
        	techList.add(technology);
        }
		insert techList;
        
        //Create fake panel entries to pass into method
        //Method needs parameters:
        //(list<Technology__c> panelTech, list<string> gradeList, string panelId, list<string> commentList, list<boolean> repanelList)
        List<String> gradeList = new List<String> {'2','4','6','8'};
        List<String> commentList = new List<String> {'test','test','test','test'};
        List<Boolean> repanelList = new List<Boolean> {true,true,false,false};
            
        //Call method and test if insert succeeds
        TechDetails.submitPanel(techList, gradeList, panelId, commentList, repanelList);
        System.assert([SELECT Technology__c, Comment__c, Repanel__c, Grade__c FROM Panel_Results__c WHERE Panel__c = :panelId].Size()==4);
        
    }
    
}