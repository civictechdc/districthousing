# A class to simulate what we'd get out of Salesforce, which is normally
# instantiated as an Intake__c class via the Databasedotcom library.  These classes
# have a ton of attributes.  We want to translate these attributes to the Applicant
# class where possible.
#
# This class is used for testing SalesforceApplicant#merge.

class FakeIntake

  # Attributes available in salesforce are as follows.
  #
  # Not all of these easily translate to our data model, but we will convert
  # what we can.
  #
  # Additional_Income_1_Type__c                 =
  # Additional_Income_1__c                      =
  # Additional_Income_2_Type__c                 =
  # Additional_Income_2__c                      =
  # Additional_Income_3_Type__c                 =
  # Additional_Income_3__c                      =
  # Address1__c                                 = 1616 Good Hope RD
  # Address2__c                                 =
  # AddressType__c                              =
  # AlternatePhoneNoType__c                     =
  # AlternatePhoneNo__c                         =
  # Alternate_Address1__c                       =
  # Alternate_Address2__c                       =
  # Alternate_City__c                           =
  # Alternate_Email__c                          =
  # Alternate_Quadrant__c                       =
  # Alternate_State__c                          = DC
  # Alternate_Ward__c                           =
  # Alternate_ZipCode__c                        =
  # Children__c                                 =
  # City__c                                     = Washington
  # ClientDisability__c                         = false
  # Comments2__c                                =
  # Custody__c                                  = false
  # DC_Health_Families__c                       = false
  # DC_Healthcare_Alliances__c                  = false
  # DClientAutoID__c                            =
  # DOB__c                                      = 1959-02-17
  # DOB_of_Youngest_Child__c                    =
  # Denied_public_benefits__c                   = false
  # EconomyII__c                                = false
  # EmployProblem__c                            = false
  # FirstName__c                                = Jason
  # Gender__c                                   = Female
  # Has_Children__c                             = false
  # Hear__c                                     =
  # HeatCool__c                                 = false
  # Housing_Situation__c                        =
  # I1ID__c                                     =
  # I2ID__c                                     =
  # IHCID__c                                    =
  # IHID__c                                     =
  # IID__c                                      =
  # IISID__c                                    =
  # Immigrant__c                                = No
  # Income_Type__c                              =
  # InitialEntryDate__c                         = 2014-12-30
  # Insurance__c                                =
  # IntakeDate__c                               = 2004-03-16T11:04:09+00:00
  # Intake__c                                   = false
  # Join_our_Pre_Employment_Program__c          =
  # LandLord__c                                 = false
  # Language_issues__c                          = false
  # LastName__c                                 = Test
  # Main_Income_Type__c                         = 0.0
  # Main_Source__c                              =
  # Medicaid__c                                 = false
  # Medical_Charities__c                        = false
  # Medicare_A__c                               = false
  # Medicare_B__c                               = false
  # MiddleInitial__c                            =
  # Middle_Name__c                              =
  # OtherDisability__c                          = false
  # Photo_ID__c                                 = false
  # Pregnant__c                                 = false
  # PrimaryPhoneNoType__c                       = Mobile
  # PrimaryPhoneNo__c                           = (301) 637-7956
  # Primary_Email__c                            =
  # Primary_Language__c                         = English
  # PrivateInsurance__c                         =
  # Private_Insurance__c                        = false
  # Proof_Of_Address_Doc__c                     = []
  # Proof_Of_Disability_Doc__c                  = []
  # Proof_Of_Income_Doc__c                      = []
  # Proof_Of_Spouse_Doc__c                      = []
  # Proof_of_Address__c                         = false
  # Proof_of_Age__c                             = false
  # Proof_of_Disability__c                      = false
  # Proof_of_Income__c                          = false
  # Proof_of_Spouse__c                          = false
  # PublicHousing__c                            = false
  # Purpose_Other__c                            =
  # Quadrant__c                                 =
  # Qualified_For_Food_Disabled__c              =
  # Qualified_For_Food_Elderly__c               =
  # Qualified_For_Food_Family__c                =
  # Race__c                                     = Black/African American
  # Receiving_Pending_Food_Stamps__c            = false
  # Refer_to_EJC__c                             =
  # Rent__c                                     =
  # SSN__c                                      =
  # Salute__c                                   =
  # Sanctioned_benefit_reduction__c             = false
  # Secondary_Income_Type__c                    =
  # Secondary_Source__c                         =
  # SeekingWorFk__c                             = false
  # SeekingWork__c                              = false
  # Speak_to_Social_Worker_Food__c              =
  # Speak_to_a_Lawyer_about_Public_Benefits__c  =
  # Speak_to_a_lawyer_Public_Benefits_Immig__c  =
  # Speak_to_a_lawyer_about_Landlord_Tenant__c  =
  # Speak_to_social_worker_about_energy__c      =
  # Speak_with_a_lawyer_about_Family_Law__c     =
  # Spouse_NU__c                                =
  # Spouse__c                                   =
  # Spouse__r                                   =
  # State__c                                    = DC
  # Student_Work_Visa__c                        = false
  # Talk_to_a_lawyer_about_public_benefits_a__c = false
  # Terminated_public_benefits__c               = false
  # TotalIncome__c                              =
  # Total_Income__c                             =
  # VA_Access__c                                = false
  # Ward__c                                     = 8
  # Why__c                                      =
  # You_Anyone_in_your_house_an_immigrant__c    = false
  # ZipCode__c                                  =
  # z_Access_Insurance__c                       =
  # z_Additional_Income_1_Type__c               =
  # z_Additional_Income_1__c                    =
  # z_Additional_Income_2_Type__c               =
  # z_Additional_Income_2__c                    =
  # z_Additional_Income_3_Type__c               =
  # z_Additional_Income_3__c                    =
  # z_Address1__c                               =
  # z_Address2__c                               =
  # z_AddressType__c                            =
  # z_AlternatePhoneNoType__c                   =
  # z_AlternatePhoneNo__c                       =
  # z_Alternate_Address1__c                     =
  # z_Alternate_Address2__c                     =
  # z_Alternate_City__c                         =
  # z_Alternate_Email__c                        =
  # z_Alternate_Quadrant__c                     =
  # z_Alternate_State__c                        = DC
  # z_Alternate_Ward__c                         =
  # z_Alternate_ZipCode__c                      =
  # z_Children__c                               =
  # z_City__c                                   =
  # z_ClientDisability__c                       = false
  # z_Comments2__c                              =
  # z_Custody__c                                = false
  # z_DOB__c                                    =
  # z_DOB_of_Youngest_Child__c                  =
  # z_Denied_public_benefits__c                 = false
  # z_EconomyII__c                              = false
  # z_EmployProblem__c                          = false
  # z_FirstName__c                              =
  # z_Gender__c                                 =
  # z_Has_Children__c                           = false
  # z_Hear__c                                   =
  # z_HeatCool__c                               = false
  # z_Housing_Situation__c                      =
  # z_Immigrant__c                              = z_No
  # z_Income_Type__c                            =
  # z_InitialEntryDate__c                       = 2014-12-30
  # z_Insurance__c                              =
  # z_IntakeDate__c                             = 2014-08-06T19:58:14+00:00
  # z_IntakeSite__c                             =
  # z_Intake__c                                 = false
  # z_Join_our_Pre_Employment_Program__c        =
  # z_LandLord__c                               = false
  # z_Language_issues__c                        = false
  # z_LastName__c                               =
  # z_Main_Income_Type__c                       =
  # z_Main_Source__c                            =
  # z_MiddleInitial__c                          =
  # z_Middle_Name__c                            =
  # z_OtherDisability__c                        = false
  # z_Photo_ID__c                               = false
  # z_Pregnant__c                               = false
  # z_PrimaryPhoneNoType__c                     =
  # z_PrimaryPhoneNo__c                         =
  # z_Primary_Email__c                          =
  # z_Primary_Language__c                       =
  # z_PrivateInsurance__c                       =
  # z_Proof_Of_Address_Doc__c                   = []
  # z_Proof_Of_Disability_Doc__c                = []
  # z_Proof_Of_Income_Doc__c                    = []
  # z_Proof_Of_Spouse_Doc__c                    = []
  # z_Proof_of_Address__c                       = false
  # z_Proof_of_Age__c                           = false
  # z_Proof_of_Disability__c                    = false
  # z_Proof_of_Income__c                        = false
  # z_Proof_of_Spouse__c                        = false
  # z_PublicHousing__c                          = false
  # z_Purpose_Other__c                          =
  # z_Quadrant__c                               =
  # z_Qualified_For_Food_Disabled__c            =
  # z_Qualified_For_Food_Elderly__c             =
  # z_Qualified_For_Food_Family__c              =
  # z_Race__c                                   =
  # z_Receiving_Pending_Food_Stamps__c          = false
  # z_Refer_to_EJC__c                           =
  # z_Rent__c                                   =
  # z_Salute__c                                 =
  # z_Sanctioned_benefit_reduction__c           = false
  # z_Secondary_Income_Type__c                  =
  # z_Secondary_Source__c                       =
  # z_SeekingWorFk__c                           = false
  # z_SeekingWork__c                            = false
  # z_Speak_to_Lawyer_about_Public_Benefits__c  =
  # z_Speak_to_Social_Worker_Food__c            =
  # z_Speak_to_lawyer_Public_Benefits_Immig__c  =
  # z_Speak_to_lawyer_about_Landlord_Tenant__c  =
  # z_Speak_to_social_worker_about_energy__c    =
  # z_Speak_with_a_lawyer_about_Family_Law__c   =
  # z_Spouse_NU__c                              =
  # z_Spouse__c                                 =
  # z_Spouse__r                                 =
  # z_State__c                                  = DC
  # z_Student_Work_Visa__c                      = false
  # z_Talk_to_lawyer_about_public_benefits__c   = false
  # z_Terminated_public_benefits__c             = false
  # z_TotalIncome__c                            =
  # z_Total_Income__c                           = 0.0
  # z_Ward__c                                   =
  # z_Why__c                                    =
  # z_ZipCode__c                                =
  # Access_Insurance__c                         = false
  # SFClientID__c                               = JasoTest17259
  # Does_your_unit_need_repairs__c              = false
  # Are_you_able_to_keep_up_with_your_rent__c   = false
  # Place_Holder__c                             = 1.0
  # Percent_Poverty_Line__c                     = 0.0
  # Eligibility__c                              = No
  # Need_Proofs__c                              = N/A - Not eligible for Food
  # Age__c                                      = 55.0
  # IntakeSite__c                               =
  # Bag_Size__c                                 = 1.0
  # Whose_address_is_this__c                    =
  # Income_Comments__c                          =
  # Intake_FY__c                                = 2004.0
  # Intake_FQ__c                                = 3.0
  # Intake_Name__c                              = Jason Test
  # Program__c                                  =
  # NRL_Info__c                                 =
  # Birth_Year__c                               = 2171959
  # On_NRL_list_Checkbox__c                     = false
  # Contact__c                                  =
  # Contact__r                                  =
  # intd__c                                     = 2004-03-16
  # Whose_phone_is_this__c                      =
  # csID__c                                     = a0EZ000000PTvK9
  # Total_House__c                              =
  # Client_barred__c                            = []
  # Date_client_bar_expires__c                  =
  # BYLEN__c                                    = 7.0
  # Address__Latitude__s                        = 38.866351
  # Address__Longitude__s                       = -76.981669
  # Behavioral_Assessments__c                   = 0.0
  # Alternate_Name__c                           =

  # Actually supported attributes so far:
  attr_accessor :Name
  attr_accessor :First_Name__c
  attr_accessor :Middle_Name__c
  attr_accessor :Last_Name__c
  attr_accessor :Primary_Address_1__c
  attr_accessor :Primary_City__c
  attr_accessor :Primary_State__c
  attr_accessor :Primary_Zip_Code__c
  attr_accessor :DOB__c
  attr_accessor :SSN__c
  attr_accessor :Primary_Phone__c
  attr_accessor :AlternatePhoneNo__c
  attr_accessor :Email_Address__c
  attr_accessor :Gender__c
  attr_accessor :Race__c
  attr_accessor :Drivers_License_Number__c
  attr_accessor :Drivers_License_State__c
  attr_accessor :Immigrant__c
  attr_accessor :Student_Status__c
  attr_accessor :Marital_Status__c
  attr_accessor :Occupation__c
  attr_accessor :Hispanic__c
  attr_accessor :State_of_Birth__c
  attr_accessor :City_of_Birth__c

  def initialize attrs
    attrs.keys.each do |k|
      send("#{k}=", attrs[k])
    end
  end
end
