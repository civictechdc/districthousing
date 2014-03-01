Resident.destroy_all
Resident.create(first_name: "Walter", last_name: "White", middle_name: "Hartwell", res_street_address: "308 Negra Arroyo Lane", res_city: "Albuquerque", res_state: "New Mexico", res_zip: "87122", ssn: "123-45-6789", dob:"7/9/1959", gender:"Male")

# Load information from all PDFs in public/forms
HousingForm.destroy_all
Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
  pdf_name = File.basename pdf_path
  form = HousingForm.create(name: pdf_name, uri: pdf_path)
  PDF_FORMS.get_field_names(pdf_path).each do |field_name|
     form.form_fields << FormField.find_or_create_by_name(field_name)
  end
end
