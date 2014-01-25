Resident.destroy_all
Resident.create(first_name: "Walter", last_name: "White", middle_name: "Hartwell", res_street_address: "308 Negra Arroyo Lane", res_city: "Albuquerque", res_state: "New Mexico", res_zip: "87122", ssn: "123-45-6789", dob:"7/9/1959", gender:"Male")

HousingForm.destroy_all
Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
  pdf_name = File.basename pdf_path
  HousingForm.create(name: pdf_name, uri: pdf_path)
end
