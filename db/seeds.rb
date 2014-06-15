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

def make_an_address(address_class=Address)
  address_class.create(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    apt: ["", "#{rand 999}", "Apartment #{rand 999}", "Unit #{('A'..'Z').to_a.sample}"].sample
  )
end

def make_a_person(person_class=Person)
  person_class.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.first_name,
    ssn: "%s-%s-%s" % [Faker::Number.number(3), Faker::Number.number(2), Faker::Number.number(4)],
    dob: rand(120*365).days.ago,
    gender: ["Female", "Male"].sample,
    phone: Faker::PhoneNumber.phone_number,
    work_phone: Faker::PhoneNumber.phone_number,
    home_phone: Faker::PhoneNumber.phone_number,
    cell_phone: Faker::PhoneNumber.phone_number,
    citizenship: Faker::Address.country,
    nationality: Faker::Address.country,
    email: Faker::Internet.email,
    # Sample races from US Census
    # http://www.census.gov/topics/population/race/about.html
    race: ["White", "Black", "American Indian", "Asian", "Pacific Islander"].sample,
    student_status: ["Not a student", "Part-time", "Full-time"].sample,
    marital_status: ["Never married", "Married", "Widowed", "Divorced"].sample,
    occupation: ["Butcher", "Baker", "Candlestick Maker"].sample,
  ).tap do |new_person|
    new_person.residence = make_an_address(Residence)
    new_person.mail_address = make_an_address(MailAddress)
  end
end

test_identity = make_a_person(Identity)
test_identity.save

test_applicant = Applicant.create
test_applicant.user = test_user

test_applicant.identity = test_identity

3.times { test_applicant.landlords << make_a_person(Landlord) }
3.times { test_applicant.household_members << make_a_person(HouseholdMember) }

test_applicant.save
