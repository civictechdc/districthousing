# Load information from all PDFs in public/forms that don't already
# exist in the database.  PDFs that are already in the database will be
# untouched, but PDFs not in the database will be added and given a name based
# on their filename.

require 'csv'
require 'open-uri'
require 'json'

def download_pdf uri, name, where
  # Download the file to the public/forms/ directory, and generate a path
  puts "Download #{name} from #{uri}"
  output_filename = "#{where}#{Slugify.slugify(name)}.pdf"
  system("wget '#{uri}' --no-check-certificate --output-document=#{output_filename}")
  output_filename
end

require 'find'

desc "Load PDFs from public/forms/external"
task seed_pdfs_external: :environment do
  HousingForm.transaction do
    FormField.transaction do
      HousingForm.destroy_all
      glob_pattern = Rails.root.join "public", "forms", "external", "*.pdf"
      Dir.glob(glob_pattern).each do |path|
        if FileTest.file?(path)
          puts path
          form_name = File.basename(path).sub(/.pdf$/, '')
          HousingForm.create(name: form_name, path: path)
        end
      end
    end
  end
end

# Retrieve PDFs from districthousing.org.  Code for DC team members who work on
# editing PDFs for District Housing are encouraged to put their most up-to-date
# PDFs on districthousing.org, so the progress is visible, and other team
# members can easily try filling out the PDFs themselves.
#
# This task allows new deployments of District Housing (such as the one at Bread
# for the City) to retrieve the most up-to-date PDFs from districthousing.org to
# their local database.

desc "Retrieve PDFs from districthousing.org."
task pull_pdfs: :environment do
  open('https://districthousing.org/housing_forms.json',
       {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}) do |housing_form_json|
    json = housing_form_json.read
    housing_forms = JSON.parse(json)
    housing_forms.each do |housing_form|
      # If the housing form was already pulled before, update it, unless someone
      # has uploaded a new form on the local instance.
      existing_form = HousingForm.find_by(remote_id: housing_form['id'])
      if existing_form and existing_form.updated_locally?
        puts "Ignoring updates due to local changes: #{existing_form['name']}".
          yellow
        next
      end

      # We use this hash to update the new housing form.  Don't go about
      # changing existing IDs!
      housing_form['remote_id'] = housing_form['id']
      housing_form.delete('id')

      unless housing_form['url'].blank?
        download_uri = "https://districthousing.org#{housing_form['url']}"
        housing_form['path'] = download_pdf(
          download_uri,
          housing_form['name'],
          'public/forms/')
      end

      # 'url' is not a HousingForm database field.  Remove it so we can use this
      # hash to update or create.
      housing_form.delete('url')
      # 'lat' and 'long' are removed in favor of 'latitude' and 'longitude'
      housing_form.delete('lat')
      housing_form.delete('long')

      if existing_form.nil?
        puts "New PDF: #{housing_form['name']}".green
        HousingForm.create(housing_form)
      else
        puts "Update PDF: #{existing_form['name']}".cyan
        existing_form.update(housing_form)
      end
    end
  end
end
