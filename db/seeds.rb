require 'csv'
require 'open-uri'

# Load information from all PDFs in public/forms that don't already
# exist in the database.  PDFs that are already in the database will be
# untouched, but PDFs not in the database will be added and given a name based
# on their filename.

def download_pdf uri, name
  # Download the file to the public/forms/ directory, and generate a path
  output_filename = "public/forms/#{name}.pdf"
  system("wget #{uri} --output-document=#{output_filename}")
  output_filename
end

def pdf_filename_base csv_row
  "stock/#{csv_row['lat']}_#{csv_row['lng']}"
end

HousingForm.transaction do
  FormField.transaction do
    # Remove existing HousingForms with PDF paths that don't exist on disk
    HousingForm.all.each do |h|
      unless h.path.blank? or File.exists? h.path
        h.destroy
      end
    end

    # Add seed forms only if they don't already exist
    CSV.foreach(Rails.root.join("public","buildings3.csv"), :headers => true) do |row|
      unless HousingForm.find_by(name: row['Property Name'])
        path = nil
        unless row['uri'].blank?
          path = download_pdf(row['uri'], pdf_filename_base(row))
        end
        HousingForm.create(name: row['Property Name'], location: row['Property Address'], lat: row['lat'], long: row['lng'], path: path)
      end
    end

    # Look for any new user-added (not from the seed CSV) PDFs in public/forms
    Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
      unless HousingForm.find_by(path: pdf_path)
        HousingForm.create(path: pdf_path)
      end
    end
  end
end

# Re-initialize all fields from their PDFs
FormField.delete_all
HousingForm.all.each do |h|
  h.initialize_from_disk!
end

# Now, make a bunch of fake applicants.

require 'faker'

Applicant.destroy_all
Person.destroy_all
User.destroy_all
Residence.destroy_all
Address.destroy_all
Income.destroy_all
Employment.destroy_all
CriminalHistory.destroy_all
CrimeType.destroy_all
Contact.destroy_all

# Populate crime types
CrimeType.create(name: "felony", label: "Felony")
CrimeType.create(name: "sex_offense", label: "Sex Offense")
CrimeType.create(name: "evicted_from_residence", label: "Evicted from your residence")
CrimeType.create(name: "evicted_from_residence_for_drugs", label: "Evicted from your residence because of drug or stubstance abuse")

# Seed a test user
test_user = User.create(
  :email => "testuser@districthousing.org",
  :password => "password"
)

30.times do
  ApplicantFactory.make_a_sample_applicant(test_user)
end

sample_user = User.create(
  :email => "sampleuser@districthousing.org",
  :password => "password"
)
sample_user.role = User::USER_ROLES[:sample]
sample_user.save!

ApplicantFactory.make_a_sample_applicant(sample_user)
