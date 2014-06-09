# Load information from all PDFs in public/forms
HousingForm.delete_all
FormField.delete_all

pdf_names_and_fields = Hash.new

Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
  pdf_names_and_fields[pdf_path] = Array.new

  PDF_FORMS.get_field_names(pdf_path).each do |field_name|
    pdf_names_and_fields[pdf_path] << field_name
  end
end

FormField.transaction do
  pdf_names_and_fields.each_value.reduce(:|).each do |field_name|
    FormField.create(name:field_name)
  end
end

HousingForm.transaction do
  pdf_names_and_fields.each do |pdf_path, field_names|
    pdf_name = File.basename pdf_path
    form = HousingForm.create(name: pdf_name, uri: pdf_path)
    field_names.each do |field_name|
      form.form_fields << FormField.where(name: field_name)
    end
  end
end

require 'faker'

Applicant.destroy_all
Person.destroy_all
User.destroy_all

# Seed a test user
test_user = User.create(
  :email => "testuser@districthousing.org",
  :password => "password"
)
test_user.save

def make_a_person(person_class=Person)
  person_class.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.first_name,
    ssn: Faker::Number.number(9),
    dob:"7/9/1959",
    gender: ["Female", "Male"].sample,
    phone: Faker::PhoneNumber.phone_number,
    work_phone: Faker::PhoneNumber.phone_number,
    home_phone: Faker::PhoneNumber.phone_number,
    cell_phone: Faker::PhoneNumber.phone_number,
    preferred_phone: Faker::PhoneNumber.phone_number,
    citizenship: Faker::Address.country,
    nationality: Faker::Address.country,
    email: Faker::Internet.email,
    # Sample races from US Census
    # http://www.census.gov/topics/population/race/about.html
    race: ["White", "Black", "American Indian", "Asian", "Pacific Islander"].sample,
    student_status: ["Not a student", "Part-time", "Full-time"].sample,
    marital_status: ["Never married", "Married", "Widowed", "Divorced"].sample,
  )
end

test_identity = make_a_person(Identity)

test_residence = Address.create(
  street: "742 Evergreen Terrace",
  city: "Springfield",
  state: "Kentucky",
  zip: 11111,
)

test_mail = Address.create(
  street: "1600 Clifton Road",
  city: "Atlanta",
  state: "GA",
  zip: "30333",
)

test_identity.residence = test_residence
test_identity.mail = test_mail

test_identity.previous_ssns << PreviousSsn.create( number: Faker::Number.number(8))
test_identity.previous_ssns << PreviousSsn.create( number: Faker::Number.number(8))
test_identity.previous_ssns << PreviousSsn.create( number: Faker::Number.number(8))
test_identity.save

test_applicant = Applicant.create
test_applicant.user = test_user

test_applicant.identity = test_identity

3.times do
  test_applicant.landlords << make_a_person(Landlord)
end

3.times do
  test_applicant.household_members << make_a_person(HouseholdMember)
end

test_applicant.save
