@isTest
public class TestPanelViewAPEXController {
    @isTest
    public static void test(){
        // Negative testing
        List<Panel_Results__c> panelResultList = PanelViewAPEXController.getPanelResults('This is not an Id');
        System.assertEquals(0, panelResultList.Size());
        
        // Setting up minimal test data
        Curriculum__c currTest = new Curriculum__c();
        currTest.Name = 'Test Curriculum';
        insert currTest;
        
        Technology__c techTest = new Technology__c();
        techTest.Curriculum__c = currTest.Id;
        techTest.Name = 'Technology test';
        techTest.Weight_in_Panel_Results__c = 100;
        insert techTest;
        
        Panel__c panelTest = new Panel__c();
        panelTest.Name = 'This is the name of a random test panel';
        insert panelTest;
        
        Panel_Results__c panResTest = new Panel_Results__c();
        panResTest.Grade__c = 100;
        panResTest.Panel__c = panelTest.Id;
        panResTest.Technology__c = techTest.Id;
        insert panResTest;
        
        // Positive testing
        panelResultList = PanelViewAPEXController.getPanelResults(panelTest.Id);
        System.assertEquals(panResTest.Id, panelResultList[0].Id);
        
        // Negative testing
        panelResultList = PanelViewAPEXController.getPanelResults('This is not an Id');
        System.assertEquals(0, panelResultList.Size());
    }
}