# Panelforce
PanelForce

Features
  ●	Conduct A Panel/Save a PanelSheet
    ○	Lightning Component (Input Fields/Picklists/etc)
      ■	Interview Details (Must be input every time you start panel process)
        ●	Contact - person being interviewed
        ●	Assigned To - user doing the interview
        ●	Date/Time - DateTime of the interview
        ●	Duration - length of interview allotted
        ●	Panel Round - Attempt Number
        ●	Curriculum - curriculum being tested over
        ●	Recording Link - interview call link
        ●	Recording Consent - yes/no
        ●	Mode - method of call (skype, etc)
        ●	Stability - quality of the call
        ●	Training Assignment - Batch Number/Technology/Location
        ●	Placement - Date of placement / Name of Company / JobID
      ■	Technical Assessment  (Tech Autofilled based on Curriculum Selected)
        ●	Technology Name
          ○	SubTechnology being tested over (Core Java, Hibernate, etc)
        ●	Max Score
          ○	Total available points for that subTech
        ●	Actual Score
          ○	Score panel taker received in this subTech
        ●	Repanel
          ○	True or False value
          ○	(Need to repanel in this subTech or not)
      ■	Save 
        ●	Save panel results to chosen Associate
        ●	Will save to Panel object
        ●	Associates can have multiple assessments/panel attempts
●	View detail panel results for individual panels/View the panel history of an associate/ Filter panel    results by name
  ○	View Panel (tab)
    ■	Enter Associate Name OR Associate ID
    ■	Select specific Panel Record from that results ListView
      ●	Lightning Component
        ○	Details of that specific panel
        ○	Can have field with Pass or Fail
          ■	Single failed technology means a failed panel
●	Build a new curriculum with associated scoring matrix
  ○	Curriculum record is updated when technologies are added to it
  ○	Perhaps a Lightning Button to Print Curriculum on the lightning page (?)
Lightning Components
  ●	Submit new Panel
  ●	View Panel List
  ●	View Panel Record
Data Model
  ●	Panel Object
    ○	Has lookup to Associates
    ○	Has child - Grades
    ○	Fields
      ■	Contact - person being interviewed
      ■	Assigned To - user doing the interview
      ■	Date/Time - DateTime of the interview
      ■	Duration - length of interview allotted
      ■	Panel Round - Attempt Number
      ■	Curriculum - curriculum being tested over
      ■	Recording Link - interview call link
      ■	Recording Consent - yes/no
      ■	Mode - method of call (skype, etc)
      ■	Stability - quality of the call
      ■	Training Assignment - Batch Number/Technology/Location
      ■	Placement - Date of placement / Name of Company / JobID
●	Grades Object
  ○	Junction Object between Panel and Technologies
  ○	Is Child of Panel
  ○	Fields
    ■	Lookup - Technology
    ■	Result - Grade for that technology within that panel
●	Technology Object
  ■	Has child - Curriculum
  ■	Fields
    ●	Name
    ●	Questions (text area type field?)
  ■	Will populate with records such as Soft Skills, Project, Core Java, Hibernate, etc)
●	Associate Object
  ○	Using Contact Object (Record Type for Contact Object)
  ○	Fields
    ■	Basic Contact Info Fields
    ■	Batch
    ■	Graduation Date
    ■	Work Experience
    ■	Certs
  ○	Can be associated with many Panels (Related Lists)
●	Curriculum Object
  ○	Associated with multiple panels (Related Lists)
  ○	Fields
    ■	Should only be child of Technologies
      ●	Display all involved Technologies in Related List
  ○	Validation Rule
    ■	Must be 100 total weight
    ■	90 is technology
    ■	5 is Project
    ■	5 is SoftSkill
●	Panelist Object
  ○	Using User object (Panelist is internal User)
  ○	Needs Profile
    ○	Panelist
      ■	Access to relevant Objects/Fields
  ●	Need to create Roles
    ○	Can create roles to control what panelist can give what panels (Java panelists/Salesforce panelists, etc)
    ○	Or have access to what panels
  ●	Associated with multiple Panels (Related Lists)
  ●	What License do the users need for this (?)
