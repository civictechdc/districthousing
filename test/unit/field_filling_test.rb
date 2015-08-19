require 'test_helper'

class FieldFillingTest < ActiveSupport::TestCase

  def setup
    @one = applicants(:one)
    valid = @one.valid?
    assert valid, @one.errors.messages
  end

  test "fills basic personal information" do
    assert_equal "One John McOne", @one.field("Name")
    assert_equal "One John McOne", @one.field("FullName")
    assert_equal "One John McOne", @one.field("FullName1")
    assert_equal "O", @one.field("FirstInitial")
    assert_equal "J", @one.field("MiddleInitial")
    assert_equal "M", @one.field("LastInitial")
    assert_equal "(202) 586-5000", @one.field("WorkPhone")
    assert_equal "02/03/1981", @one.field("DOB")
    assert_equal "02", @one.field("DOBMM")
    assert_equal "03", @one.field("DOBDD")
    assert_equal "1981", @one.field("DOBYYYY")
    assert_equal "one@districthousing.org", @one.field("Email")
    assert_equal "One", @one.field("FirstName")
    assert_equal "McOne", @one.field("LastName")
    assert_equal "(202) 208-4743", @one.field("CellPhone")
    assert_equal "(202) 272-0167", @one.field("HomePhone")
    assert_equal "(202) 208-4743", @one.field("Phone")
    assert_equal "111-11-1111", @one.field("SSN")
    assert_equal "Male", @one.field("Gender")
    assert_equal "M", @one.field("GenderInitial")
    assert_equal "United States", @one.field("CountryOfBirth")
    assert_equal "VA", @one.field("BirthState")
    assert_equal "Springfield", @one.field("BirthCity")
    assert_equal "Yes", @one.field("USCitizenYesNo")
    assert_equal "Asian", @one.field("Race")
    assert_equal "Hispanic or Latino", @one.field("Ethnicity")
    assert_equal "X12345678", @one.field("DriverLicense")
    assert_equal "NY", @one.field("DriverLicenseState")
    assert_equal "01/01/2020", @one.field("DriverLicenseExpire")
    assert_equal "01", @one.field("DriverLicenseExpireDD")
    assert_equal "01", @one.field("DriverLicenseExpireMM")
    assert_equal "2020", @one.field("DriverLicenseExpireYYYY")
    assert_equal "Self", @one.field("Relationship")
    assert_equal "Yes", @one.field("MarriedYesNo")
    assert_equal "Yes", @one.field("MarriedYes")
    assert_equal "", @one.field("MarriedNo")
    assert_equal "Y", @one.field("MarriedYN")
    assert_equal "Yes", @one.field("MarriedYesNo")
    assert_equal "Part-time", @one.field("StudentStatus")
    assert_equal "N", @one.field("StudentStatusFullTimeYN")
    assert_equal "No", @one.field("StudentStatusFullTimeYesNo")
    assert_equal "Y", @one.field("StudentStatusYN")
    assert_equal "Yes", @one.field("StudentStatusYesNo")
  end

  test "fills addresses" do
    assert_equal "1 Residence Lane, Residenceburg, MD, 33333", @one.field("Address")
    assert_equal "1 Residence Lane, Residenceburg, MD, 33333", @one.field("Address1")
    assert_equal "Residenceburg", @one.field("AddressCity")
    assert_equal "MD", @one.field("AddressState")
    assert_equal "1 Residence Lane", @one.field("AddressStreet")
    assert_equal "33333", @one.field("AddressZip")
    assert_equal "2 Residence Grove, New Residenceville, OK, 44444", @one.field("Address2")
    assert_equal "New Residenceville", @one.field("Address2City")
    assert_equal "OK", @one.field("Address2State")
    assert_equal "2 Residence Grove", @one.field("Address2Street")
    assert_equal "44444", @one.field("Address2Zip")
    assert_equal "111 Fake Street, Oneville, DC, 11111", @one.field("Mail")
    assert_equal "Oneville", @one.field("MailCity")
    assert_equal "DC", @one.field("MailState")
    assert_equal "111 Fake Street", @one.field("MailStreet")
    assert_equal "11111", @one.field("MailZip")
  end

  test "fills residences" do
    assert_equal "$100.00", @one.field("Residence1Rent")
    assert_equal "$200.00", @one.field("Residence2Rent")
    assert_equal "Changed jobs", @one.field("Residence1ReasonForMoving")
    assert_equal "Neighbors annoying", @one.field("Residence2ReasonForMoving")
  end

  test "fills contact information" do
    assert_equal "111.897.3785", @one.field("Contact1CellPhone")
    assert_equal "Oneville", @one.field("Contact1AddressCity")
    assert_equal "Contact1 Onerson Onesie", @one.field("Contact1Name")
    assert_equal "Plumber", @one.field("Contact1Relationship")
    assert_equal "Contact2 Twonerson Twosie", @one.field("Contact2Name")
    assert_equal "two@two.info", @one.field("Contact2Email")
  end

  test "fills income information" do
    assert_equal "pension", @one.field("Income1Source")
    assert_equal "$333.00", @one.field("Income1Amount")
    assert_equal "$83.25", @one.field("Income1AmountWeekly")
    assert_equal "$166.50", @one.field("Income1AmountBiweekly")
    assert_equal "$333.00", @one.field("Income1AmountMonthly")
    assert_equal "$3996.00", @one.field("Income1AmountYearly")
    assert_equal "One John McOne", @one.field("Income2EarnerName")
    assert_equal "yearly", @one.field("Income3Interval")
  end

  test "fills household member information" do
    assert_equal "", @one.field("HH1CitizenYN")
    assert_equal "01/07/1918", @one.field("HH1DOB")
    assert_equal "HH1", @one.field("HH1FirstName")
    assert_equal "Male", @one.field("HH1Gender")
    assert_equal "Schaefer", @one.field("HH1LastName")
    assert_equal "HH1 Charley Schaefer", @one.field("HH1Name")
    assert_equal "Grandmother", @one.field("HH1Relationship")
    assert_equal "555-44-8271", @one.field("HH1SSN")
    assert_equal "", @one.field("HH2CitizenYN")
    assert_equal "", @one.field("HH2DOB")
    assert_equal "HH2", @one.field("HH2FirstName")
    assert_equal "", @one.field("HH2Gender")
    assert_equal "", @one.field("HH2LastName")
    assert_equal "HH2", @one.field("HH2Name")
    assert_equal "Son", @one.field("HH2Relationship")
    assert_equal "", @one.field("HH2SSN")
    assert_equal "", @one.field("HH3CitizenYN")
    assert_equal "", @one.field("HH3DOB")
    assert_equal "", @one.field("HH3FirstName")
    assert_equal "", @one.field("HH3Gender")
    assert_equal "", @one.field("HH3LastName")
    assert_equal "", @one.field("HH3Name")
    assert_equal "", @one.field("HH3Relationship")
    assert_equal "", @one.field("HH3SSN")
    assert_equal "", @one.field("HH4CitizenYN")
    assert_equal "", @one.field("HH4DOB")
    assert_equal "", @one.field("HH4FirstName")
    assert_equal "", @one.field("HH4Gender")
    assert_equal "", @one.field("HH4LastName")
    assert_equal "", @one.field("HH4Name")
    assert_equal "", @one.field("HH4Relationship")
    assert_equal "", @one.field("HH4SSN")
    assert_equal "", @one.field("HH5CitizenYN")
    assert_equal "", @one.field("HH5DOB")
    assert_equal "", @one.field("HH5FirstName")
    assert_equal "", @one.field("HH5Gender")
    assert_equal "", @one.field("HH5LastName")
    assert_equal "", @one.field("HH5Name")
    assert_equal "", @one.field("HH5Relationship")
    assert_equal "", @one.field("HH5SSN")
  end

  test "fills landlord information" do
    assert_equal "111 Fake Street, Oneville, DC, 11111", @one.field("LL1Mail")
    assert_equal "LL1", @one.field("LL1Name")
    assert_equal "(555) 555-5555", @one.field("LL1Phone")
    assert_equal "222 Fake Street, Two Town, AK, 22222", @one.field("LL2Mail")
    assert_equal "LL2", @one.field("LL2Name")
    assert_equal "(666) 666-6666", @one.field("LL2Phone")
  end

  test "fills criminal history information" do
    assert_equal "Felony", @one.field("Crime1Type")
    assert_equal "MyString", @one.field("Crime1Description")
    assert_equal "2014", @one.field("Crime2Date")
    assert_equal "One", @one.field("Crime2FirstName")
    assert_equal "Felony", @one.field("CrimeType")
  end

  test "other fields" do
    assert_equal "", @one.field("Accommodations")
    assert_equal "", @one.field("Accommodations2")
    assert_equal "", @one.field("AlimonyN")
    assert_equal "", @one.field("AlimonyY")
    assert_equal "", @one.field("Arabic")
    assert_equal "", @one.field("Armenian")
    assert_equal "", @one.field("AssetsIncN")
    assert_equal "", @one.field("AssetsIncY")
    assert_equal "", @one.field("BankNameCheck")
    assert_equal "", @one.field("BankNameOth")
    assert_equal "", @one.field("BankNameSav")
    assert_equal "", @one.field("Cambodian")
    assert_equal "", @one.field("CashGiftsN")
    assert_equal "", @one.field("CashGiftsY")
    assert_equal "", @one.field("Chamorro")
    assert_equal "", @one.field("CheckingAcct")
    assert_equal "", @one.field("CheckingBalance")
    assert_equal "", @one.field("ChildSupIncN")
    assert_equal "", @one.field("ChildSupIncY")
    assert_equal "", @one.field("ChineseSimp")
    assert_equal "", @one.field("ChineseTrad")
    assert_equal "", @one.field("CitYN")
    assert_equal "", @one.field("ConvictionsN")
    assert_equal "", @one.field("Croatian")
    assert_equal "", @one.field("Czech")
    assert_equal "", @one.field("Disability")
    assert_equal "", @one.field("Dutch")
    assert_equal "", @one.field("EmpIncN")
    assert_equal "", @one.field("EmpIncY")
    assert_equal "", @one.field("English")
    assert_equal "", @one.field("EvictDrugsN")
    assert_equal "", @one.field("EvictDrugsY")
    assert_equal "", @one.field("Farsi")
    assert_equal "", @one.field("French")
    assert_equal "", @one.field("German")
    assert_equal "", @one.field("Greek")
    assert_equal "", @one.field("Haitian")
    assert_equal "", @one.field("Hindi")
    assert_equal "", @one.field("Hmong")
    assert_equal "", @one.field("Hungarian")
    assert_equal "", @one.field("Ilocano")
    assert_equal "", @one.field("Italian")
    assert_equal "", @one.field("Japanese")
    assert_equal "", @one.field("Korean")
    assert_equal "", @one.field("LPR")
    assert_equal "", @one.field("Laotian")
    assert_equal "", @one.field("LiveWithYou")
    assert_equal "", @one.field("LiveWithYouN")
    assert_equal "", @one.field("LiveWithYouY")
    assert_equal "", @one.field("MCareN")
    assert_equal "", @one.field("MCareY")
    assert_equal "", @one.field("OtherAcct")
    assert_equal "", @one.field("OtherBalance")
    assert_equal "", @one.field("OutstandingBillsN")
    assert_equal "", @one.field("OutstandingBillsY")
    assert_equal "", @one.field("OwnHomeN")
    assert_equal "", @one.field("OwnHomeY")
    assert_equal "", @one.field("PayChildcareN")
    assert_equal "", @one.field("PayChildcareY")
    assert_equal "", @one.field("PdInsN")
    assert_equal "", @one.field("PdInsY")
    assert_equal "", @one.field("PensionN")
    assert_equal "", @one.field("PensionY")
    assert_equal "", @one.field("Polish")
    assert_equal "", @one.field("Portuguese")
    assert_equal "", @one.field("Russian")
    assert_equal "", @one.field("SSABensN")
    assert_equal "", @one.field("SSABensY")
    assert_equal "", @one.field("SavingsAcct")
    assert_equal "", @one.field("SavingsBalance")
    assert_equal "", @one.field("Serbian")
    assert_equal "", @one.field("SexOffenderN")
    assert_equal "", @one.field("SexOffenderY")
    assert_equal "", @one.field("Slovak")
    assert_equal "", @one.field("SoldPropertyN")
    assert_equal "", @one.field("SoldPropertyY")
    assert_equal "", @one.field("Spanish")
    assert_equal "", @one.field("SubAbuseN")
    assert_equal "", @one.field("SubAbuseY")
    assert_equal "", @one.field("TANFIncN")
    assert_equal "", @one.field("TANFIncY")
    assert_equal "", @one.field("Tagalog")
    assert_equal "", @one.field("Text1")
    assert_equal "", @one.field("Text247")
    assert_equal "", @one.field("Text248")
    assert_equal "", @one.field("Text249")
    assert_equal "", @one.field("Text250")
    assert_equal "", @one.field("Text251")
    assert_equal "", @one.field("Text252")
    assert_equal "", @one.field("Text253")
    assert_equal "", @one.field("Text254")
    assert_equal "", @one.field("Text255")
    assert_equal "", @one.field("Text256")
    assert_equal "", @one.field("Text257")
    assert_equal "", @one.field("Text258")
    assert_equal "", @one.field("Text259")
    assert_equal "", @one.field("Text260")
    assert_equal "", @one.field("Text261")
    assert_equal "", @one.field("Text262")
    assert_equal "", @one.field("Text266")
    assert_equal "", @one.field("Text270")
    assert_equal "", @one.field("Text274")
    assert_equal "", @one.field("Text281")
    assert_equal "", @one.field("Text282")
    assert_equal "", @one.field("Text3")
    assert_equal "", @one.field("Text4")
    assert_equal "", @one.field("Text7")
    assert_equal "", @one.field("Text8")
    assert_equal "", @one.field("Text9")
    assert_equal "", @one.field("Thai")
    assert_equal "", @one.field("Tongan")
    assert_equal "", @one.field("Ukranian")
    assert_equal "", @one.field("UnempIncN")
    assert_equal "", @one.field("UnempIncY")
    assert_equal "", @one.field("UpcomingBillsN")
    assert_equal "", @one.field("UpcomingBillsY")
    assert_equal "", @one.field("Urdu")
    assert_equal "", @one.field("Viet")
    assert_equal "", @one.field("Yiddish")
  end

  test 'fills races' do
    app = applicants(:one)

    app.identity.race = "NativeAmerican"
    assert_equal "Native American", app.field("Race")

    assert_equal "", app.field("RaceAsianY")
    assert_equal "", app.field("RaceBlackY")
    assert_equal "Y", app.field("RaceNativeAmericanY")
    assert_equal "", app.field("RaceOtherY")
    assert_equal "", app.field("RacePacificIslanderY")
    assert_equal "", app.field("RaceWhiteY")
    assert_equal "", app.field("RaceDeclineY")

    app.identity.race = "Asian"
    assert_equal "Asian", app.field("Race")

    assert_equal "Y", app.field("RaceAsianY")
    assert_equal "", app.field("RaceBlackY")
    assert_equal "", app.field("RaceNativeAmericanY")
    assert_equal "", app.field("RaceOtherY")
    assert_equal "", app.field("RacePacificIslanderY")
    assert_equal "", app.field("RaceWhiteY")
    assert_equal "", app.field("RaceDeclineY")

    app.identity.race = "Black"
    assert_equal "Black", app.field("Race")

    assert_equal "", app.field("RaceAsianY")
    assert_equal "Y", app.field("RaceBlackY")
    assert_equal "", app.field("RaceNativeAmericanY")
    assert_equal "", app.field("RaceOtherY")
    assert_equal "", app.field("RacePacificIslanderY")
    assert_equal "", app.field("RaceWhiteY")
    assert_equal "", app.field("RaceDeclineY")

    app.identity.race = "PacificIslander"
    assert_equal "Pacific Islander", app.field("Race")

    assert_equal "", app.field("RaceAsianY")
    assert_equal "", app.field("RaceBlackY")
    assert_equal "", app.field("RaceNativeAmericanY")
    assert_equal "", app.field("RaceOtherY")
    assert_equal "Y", app.field("RacePacificIslanderY")
    assert_equal "", app.field("RaceWhiteY")
    assert_equal "", app.field("RaceDeclineY")

    app.identity.race = "Other"
    assert_equal "Other", app.field("Race")

    assert_equal "", app.field("RaceAsianY")
    assert_equal "", app.field("RaceBlackY")
    assert_equal "", app.field("RaceNativeAmericanY")
    assert_equal "Y", app.field("RaceOtherY")
    assert_equal "", app.field("RacePacificIslanderY")
    assert_equal "", app.field("RaceWhiteY")
    assert_equal "", app.field("RaceDeclineY")

    app.identity.race = "White"
    assert_equal "White", app.field("Race")

    assert_equal "", app.field("RaceAsianY")
    assert_equal "", app.field("RaceBlackY")
    assert_equal "", app.field("RaceNativeAmericanY")
    assert_equal "", app.field("RaceOtherY")
    assert_equal "", app.field("RacePacificIslanderY")
    assert_equal "Y", app.field("RaceWhiteY")
    assert_equal "", app.field("RaceDeclineY")

    app.identity.race = "Decline"
    assert_equal "Decline to State", app.field("Race")

    assert_equal "", app.field("RaceAsianY")
    assert_equal "", app.field("RaceBlackY")
    assert_equal "", app.field("RaceNativeAmericanY")
    assert_equal "", app.field("RaceOtherY")
    assert_equal "", app.field("RacePacificIslanderY")
    assert_equal "", app.field("RaceWhiteY")
    assert_equal "Y", app.field("RaceDeclineY")
  end

  test 'fills ethnicities' do
    app = applicants(:one)

    app.identity.ethnicity = "Hispanic"
    assert_equal "Hispanic or Latino", app.field("Ethnicity")

    assert_equal "Y", app.field("EthnicityHispanicY")
    assert_equal "", app.field("EthnicityNotHispanicY")
    assert_equal "", app.field("EthnicityDeclineY")

    app.identity.ethnicity = "NotHispanic"
    assert_equal "Not Hispanic or Latino", app.field("Ethnicity")

    assert_equal "", app.field("EthnicityHispanicY")
    assert_equal "Y", app.field("EthnicityNotHispanicY")
    assert_equal "", app.field("EthnicityDeclineY")

    app.identity.ethnicity = "Decline"
    assert_equal "Decline to State", app.field("Ethnicity")

    assert_equal "", app.field("EthnicityHispanicY")
    assert_equal "", app.field("EthnicityNotHispanicY")
    assert_equal "Y", app.field("EthnicityDeclineY")
  end

  test 'fills boolean fields in a way that makes sense' do
    app = applicants(:one)
    app.identity.ethnicity = "Hispanic"

    # Tick/T values are special.  They are only ever "Yes" or blank.
    # A "Yes" in a PDF tickbox value will tick the box.

    assert_equal "Y",   app.field("EthnicityHispanicY")
    assert_equal "Yes", app.field("EthnicityHispanicYes")
    assert_equal "",    app.field("EthnicityHispanicN")
    assert_equal "",    app.field("EthnicityHispanicNo")
    assert_equal "Y",   app.field("EthnicityHispanicYN")
    assert_equal "Yes", app.field("EthnicityHispanicYesNo")

    assert_equal "Yes", app.field("EthnicityHispanicTickYes")
    assert_equal "Yes", app.field("EthnicityHispanicT")
    assert_equal "",    app.field("EthnicityHispanicTickNo")

    app.identity.ethnicity = "NotHispanic"

    assert_equal "",    app.field("EthnicityHispanicY")
    assert_equal "",    app.field("EthnicityHispanicYes")
    assert_equal "N",   app.field("EthnicityHispanicN")
    assert_equal "No",  app.field("EthnicityHispanicNo")
    assert_equal "N",   app.field("EthnicityHispanicYN")
    assert_equal "No",  app.field("EthnicityHispanicYesNo")

    assert_equal "",    app.field("EthnicityHispanicTickYes")
    assert_equal "",    app.field("EthnicityHispanicT")
    assert_equal "Yes", app.field("EthnicityHispanicTickNo")
  end

  test 'nationality and citizenship are the same' do
    app = applicants(:one)

    assert_equal "US Citizen",    app.field("Citizenship")
    assert_equal "US Citizen",    app.field("Nationality")
  end
end