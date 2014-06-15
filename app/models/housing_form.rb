class HousingForm < ActiveRecord::Base
  attr_accessible :name, :uri, :location, :lat, :long
  has_and_belongs_to_many :form_fields

  def detect_location!
    metadata_output = PDF_FORMS.call_pdftk(uri, "dump_data")
    if /InfoKey: Location\nInfoValue: (.+)\n/.match(metadata_output)
      update(location: $1)
    end
  end
end
