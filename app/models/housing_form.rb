class HousingForm < ActiveRecord::Base
  attr_accessible :name, :uri, :location, :lat, :long
  has_and_belongs_to_many :form_fields

  class << self
    def create_from_path path
      pdf_name = File.basename path
      new_form = new(name: pdf_name, uri: path)

      PDF_FORMS.get_field_names(path).each do |field_name|
        new_form.form_fields << FormField.find_or_create_by(name: field_name)
      end

      new_form.detect_location!

      new_form.save
    end
  end

  def detect_location!
    metadata_output = PDF_FORMS.call_pdftk(uri, "dump_data")
    if /InfoKey: Location\nInfoValue: (.+)\n/.match(metadata_output)
      update(location: $1)
    end
  end
end
