# Load information from all PDFs in public/forms
HousingForm.destroy_all
Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
  pdf_name = File.basename pdf_path
  form = HousingForm.create(name: pdf_name, uri: pdf_path)
  PDF_FORMS.get_field_names(pdf_path).each do |field_name|
     form.form_fields << FormField.find_or_create_by_name(field_name)
  end
end

require 'faker'

Resident.destroy_all
test_resident = Resident.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  middle_name: Faker::Name.first_name,
  res_street_address: Faker::Address.street_address,
  res_city: Faker::Address.city,
  res_state: Faker::Address.state,
  res_zip: Faker::Address.zip_code,
  mail_street_address: Faker::Address.street_address,
  mail_city: Faker::Address.city,
  mail_state: Faker::Address.state,
  mail_zip: Faker::Address.zip_code,
  ssn: Faker::Number.number(8),
  dob:"7/9/1959",
  gender:"Male",
  phone: Faker::PhoneNumber.phone_number,
  work_phone: Faker::PhoneNumber.phone_number,
  home_phone: Faker::PhoneNumber.phone_number,
  cell_phone: Faker::PhoneNumber.phone_number,
  preferred_phone: Faker::PhoneNumber.phone_number,
  citizenship: Faker::Address.country,
  nationality: Faker::Address.country,
  email: Faker::Internet.email,
  race: "White",
  student_status: "Part-time",
  marital_status: "Single",
)

test_resident.previous_ssns << PreviousSsn.create( number: Faker::Number.number(8))
test_resident.previous_ssns << PreviousSsn.create( number: Faker::Number.number(8))

