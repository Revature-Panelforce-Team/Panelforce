// description: a data factory used to produce test data from static resources.
// tip: DataFactory.createAll() can be used to create all Panelforce test data.


@isTest
public class DataFactory {  

    
    // can only have one panelist.
    // panelist id is generated at runtime and assigned to panel objects after creation
    private static Id panelistid;
    
    
    
    // creates a panelist for use with panel objects
    public static User createPanelist() {
        
        User panelist;
        
        // if the panelist hasn't been created already
        if (panelistid == NULL) {
            
            // retrieve standard profile id
            Profile prof;
            try {
                prof = [select Id from Profile where Name='Standard User'];
            } catch (Exception e) {
                System.assert(false, 'DataFactory.createPanelist: Failed to find Standard User profile. '+e.getMessage());
            }
            
            // create panelist with standard profile
            panelist = new User(Alias='cturn', Email='coreyturner@datafactory.com', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LastName='Turner', LocaleSidKey='en_US', ProfileId=prof.Id, TimeZoneSidKey='America/Los_Angeles', Username='coreyturner@datafactory.com');
            try {
                insert panelist;
                panelistid = panelist.Id; // update static var with id generated from insertion
            } catch (Exception e) {
                System.assert(false, 'DataFactory.createPanelist: Failed to create panelist. '+e.getMessage());
            }
        }
        return panelist;
    }
    
    
    
    // creates a set of associates using the 'associates' static resource
    public static List<Contact> createAssociates() {
        
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
        
        return associates;
    }
    
    
    
    // creates a set of curricula using the 'curricula' static resource
    public static List<Curriculum__c> createCurricula() {
        
        // load curricula from static resource
        List<Curriculum__c> curricula;
        try {
            curricula = Test.loadData(Curriculum__c.sObjectType, 'curricula');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createCurricula: Failed to load curricula. '+e.getMessage());
        }
        
        return curricula;
    }
    
    
    
    // creates a set of technologies using the 'technologies' static resource
    // note: curricula needs to be loaded first due to relationships
    public static List<Technology__c> createTechnologies() {
        
        // load technologies from static resource
        List<Technology__c> technologies;
        try {
            technologies = Test.loadData(Technology__c.sobjectType, 'technologies');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createTechnologies: Failed to load technologies. '+e.getMessage());
        }
        
        return technologies;
    }
    
    
    
    // creates a set of panels using the 'panels' static resource
    // note: panelist, associates, and curricula need to be loaded/created first due to relationships
    public static List<Panel__c> createPanels() {
        
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
        
        return panels;
    }
    
    
    // creates a set of panel results for each panel using the 'panelresults' static resource
    // note: panels and technologies need to be loaded first due to relationships
    public static List<Panel_Results__c> createPanelResults() {
        
        // load panel results from static resource
        List<Panel_Results__c> results;
        try {
            results = Test.loadData(Panel_Results__c.sobjectType, 'panelresults');
        } catch (Exception e) {
            System.assert(false, 'DataFactory.createPanelResults: Failed to load panel results. '+e.getMessage());
        }
        
        return results;
    }
    
    
    
    // creates a set of curricula and their corresponding sets of technologies
    public static List<Curriculum__c> createCurriculaWithTechnologies() {
        
        // create curricula
        List<Curriculum__c> curricula = createCurricula();
        System.assert(curricula != NULL, 'DataFactory.createCurriculaWithTechnologies: Failed to create curricula.');
        
        // create technologies
        List<Technology__c> technologies = createTechnologies();
        System.assert(technologies != NULL, 'DataFactory.createCurriculaWithTechnologies: Failed to create technologies.');
        
        return curricula;
    }
    
    
    
    // creates all panelforce test data
    public static List<Panel__c> createAll() {
        
        // create panelist
        User panelist = DataFactory.createPanelist();
        System.assert(panelist != NULL, 'DataFactory.createAll: Failed to create panelist.');
        
        // create associates
        List<Contact> associates = DataFactory.createAssociates();
        System.assert(associates != NULL, 'DataFactory.createAll: Failed to create associates.');
        
        // create curricula
        List<Curriculum__c> curricula = DataFactory.createCurricula();
        System.assert(curricula != NULL, 'DataFactory.createAll: Failed to create curricula.');
        
        // create technologies
        List<Technology__c> technologies = DataFactory.createTechnologies();
        System.assert(technologies != NULL, 'DataFactory.createAll: Failed to create technologies.');
        
        // create panels
        List<Panel__c> panels = DataFactory.createPanels();
        System.assert(panels != NULL, 'DataFactory.createAll: Failed to create panels.');
        
        // create panel results
        List<Panel_Results__c> results = DataFactory.createPanelResults();
        System.assert(results != NULL, 'DataFactory.createAll: Failed to create results.');
        
        return panels;
    }
}