// description: a data factory used to produce test data from static resources.
// tip: DataFactory.createAll() can be used to create all Panelforce test data.


@isTest
public class DataFactory {  
    
    

    // some records need to be created before others
    // panelist / associates / curricula ---> panels / technologies ---> panel results
    private static Boolean panelist_created = false;
    private static Boolean associates_created = false;
    private static Boolean curricula_created = false;
    private static Boolean technologies_created = false;
    private static Boolean panels_created = false;
    private static Boolean results_created = false;
    
    
    
    // can only have one panelist.
    // panelist id is generated at runtime and assigned to panel objects after creation
    private static Id panelistid;
    
    
        
    // creates a panelist for use with panel objects
    public static User createPanelist() {
        
        System.assert(!panelist_created, 'DataFactory.createPanelist: Panelist already created.');
        
        // retrieve standard profile id
        Profile prof;
        try {
            prof = [select Id from Profile where Name='Standard User'];
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createPanelist: Failed to find Standard User profile. '+e.getMessage());
        }
        
        // create panelist with standard profile
        User panelist = new User(Alias='cturn', Email='coreyturner@datafactory.com', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LastName='Turner', LocaleSidKey='en_US', ProfileId=prof.Id, TimeZoneSidKey='America/Los_Angeles', Username='coreyturner@datafactory.com');
        try {
            insert panelist;
            panelistid = panelist.Id; // update static var with id generated from insertion
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createPanelist: Failed to create panelist. '+e.getMessage());
        }
        
        panelist_created = true;
        
        return panelist;
    }
    
    
    
    // creates a set of associates using the 'associates' static resource
    public static List<Contact> createAssociates() {
        
        System.assert(!associates_created, 'DataFactory.createAssociates: Associates already created.');
        
        // load associates from static resource
        List<Contact> associates;
        try {
            associates = Test.loadData(Contact.sobjectType, 'associates');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createAssociates: Failed to load associates. '+e.getMessage());
        }
        
        // get appropriate record type id for associates
        Id recordtypeid;
        try {
            recordtypeid = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Panel_Force_Associate').getRecordTypeId();
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createAssociates: Failed to find Panel_Force_Associate record type. '+e.getMessage());
        }
        
        //set appropriate record type for all associates and update records
        for (Contact a : associates) a.RecordTypeId = recordtypeid;
        try {
            update associates;
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createAssociates: Failed to update associate records with appropriate record type. '+e.getMessage());
        }
        
        associates_created = true;
        
        return associates;
    }
    
    
    
    // creates a set of curricula using the 'curricula' static resource
    public static List<Curriculum__c> createCurricula() {
        
        System.assert(!curricula_created, 'DataFactory.createCurricula: Curricula already created.');
        
        // load curricula from static resource
        List<Curriculum__c> curricula;
        try {
            curricula = Test.loadData(Curriculum__c.sObjectType, 'curricula');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createCurricula: Failed to load curricula. '+e.getMessage());
        }
        
        curricula_created = true;
        
        return curricula;
    }
    
    
    
    // creates a set of technologies using the 'technologies' static resource
    // note: curricula needs to be loaded first due to relationships
    public static List<Technology__c> createTechnologies() {
        
        System.assert(!technologies_created, 'DataFactory.createTechnologies: Technologies already created.');
        System.assert(curricula_created, 'DataFactory.createTechnologies: Curricula must be created before technologies.');
        
        // load technologies from static resource
        List<Technology__c> technologies;
        try {
            technologies = Test.loadData(Technology__c.sobjectType, 'technologies');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createTechnologies: Failed to load technologies. '+e.getMessage());
        }
        
        technologies_created = true;
        
        return technologies;
    }
    
    
    
    // creates a set of panels using the 'panels' static resource
    // note: panelist, associates, and curricula need to be loaded/created first due to relationships
    public static List<Panel__c> createPanels() {
        
        System.assert(!panels_created, 'DataFactory.createPanels: Panels already created.');
        System.assert(panelist_created, 'DataFactory.createPanels: Panelist must be created before panels.');
        System.assert(associates_created, 'DataFactory.createPanels: Associates must be created before panels.');
        System.assert(curricula_created, 'DataFactory.createPanels: Curricula must be created before panels.');
        
        // load panels from static resource
        List<Panel__c> panels;
        try {
            panels = Test.loadData(Panel__c.sobjectType, 'panels');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createPanels: Failed to load panels. '+e.getMessage());
        }
        
        // set panelist for all panels
        for (Panel__c panel : panels) panel.Panelist__c = panelistid;
        try {
            update panels;
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createPanels: Failed to update panels with their panelist. '+e.getMessage());
        }
        
        panels_created = true;
        
        return panels;
    }
    
    
    
    // creates a set of panel results for each panel using the 'panelresults' static resource
    // note: panels and technologies need to be loaded first due to relationships
    public static List<Panel_Results__c> createPanelResults() {
        
        System.assert(!results_created, 'DataFactory.createPanels: Panel results already created.');
        System.assert(panels_created, 'DataFactory.createPanels: Panels must be created before panel results.');
        System.assert(technologies_created, 'DataFactory.createPanels: Technologies must be created before panel results.');
        
        // load panel results from static resource
        List<Panel_Results__c> results;
        try {
            results = Test.loadData(Panel_Results__c.sobjectType, 'panelresults');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createPanelResults: Failed to load panel results. '+e.getMessage());
        }
        
        results_created = true;
        
        return results;
    }
    
    
    
    // creates all panelforce test data
    public static List<Panel__c> createAll() {
        
        // create panelist
        User panelist = DataFactory.createPanelist();
        
        // create associates
        List<Contact> associates = DataFactory.createAssociates();
        
        // create curricula
        List<Curriculum__c> curricula = DataFactory.createCurricula();
        
        // create technologies
        List<Technology__c> technologies = DataFactory.createTechnologies();
        
        // create panels
        List<Panel__c> panels = DataFactory.createPanels();
        
        // create panel results
        List<Panel_Results__c> results = DataFactory.createPanelResults();
        
        return panels;
    }
}