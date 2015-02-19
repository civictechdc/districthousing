# Load information from all PDFs in public/forms that don't already
# exist in the database.  PDFs that are already in the database will be
# untouched, but PDFs not in the database will be added and given a name based
# on their filename.

require 'csv'
require 'open-uri'

def download_pdf uri, name
  # Download the file to the public/forms/ directory, and generate a path
  output_filename = "public/forms/#{name}.pdf"
  system("wget #{uri} --output-document=#{output_filename}")
  output_filename
end

def pdf_filename_base csv_row
  "stock/#{csv_row['lat']}_#{csv_row['lng']}"
end

task seed_pdfs: :environment do
  puts "Seeding PDFs"

  HousingForm.transaction do
    FormField.transaction do
      # Add seed forms only if they don't already exist
      CSV.foreach(Rails.root.join("db","buildings.csv"), :headers => true) do |row|
        unless HousingForm.find_by(name: row['Property Name'])
          path = nil
          unless row['uri'].blank?
            path = download_pdf(row['uri'], pdf_filename_base(row))
          end
          HousingForm.create(name: row['Property Name'], location: row['Property Address'], lat: row['lat'], long: row['lng'], path: path)
        end
      end
    end
  end
end
