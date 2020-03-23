@isTest
public class TestPanelListViewPAPEXController {
    @isTest
    public static void test(){
        // Negative testing
        List<Panel__c> panelList = PanelListViewAPEXController.doSearch('Empty list');
        System.assertEquals(0, panelList.Size());
        
        // Setting up minimal test data
        Panel__c panelTest = new Panel__c();
        panelTest.Name = 'This is the name of a random test panel';
        insert panelTest;
        
        // Positive testing by name
        panelList = PanelListViewAPEXController.doSearch(panelTest.Name);
        // Making sure that the panel returned is correct
        System.assertEquals(panelTest, panelList[0]);
        
        // Positive testing by id
        panelList = PanelListViewAPEXController.doSearch(panelTest.Id);
        // Making sure that the panel returned is correct
        System.assertEquals(panelTest, panelList[0]);
        
        // Negative testing by wrong name
        panelList = PanelListViewAPEXController.doSearch(panelTest.Name + ' not in the original name');
        System.assertEquals(0, panelList.Size());
    }
}