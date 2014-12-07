class HousingForm < ActiveRecord::Base
  has_and_belongs_to_many :form_fields

  after_create { initialize_from_disk! }

  def initialize_from_disk!
    update(name: name)
    read_fields!
    detect_location!
  end

  def name
    unless read_attribute(:name).blank?
      read_attribute(:name).to_s
    else
      File.basename read_attribute(:uri)
    end
  end

  def read_fields!
    PDF_FORMS.get_field_names(uri).each do |field_name|
      form_fields << FormField.find_or_create_by(name: field_name)
    end
  end

  def detect_location!
    metadata_output = PDF_FORMS.call_pdftk(uri, "dump_data")
    if /InfoKey: Location\nInfoValue: (.+)\n/.match(metadata_output)
      update(location: $1)
    end
  end

  def field_results applicant
    @field_results ||= Hash.new do |h, key|
      h[key] = form_fields.map { |f| [f.name, key.value_for_field(f.name)] }.to_h
    end
    @field_results[applicant]
  end

  def unknown_fields applicant
    @unknown_fields ||= Hash.new do |h, key|
      h[key] = field_results(key).select { |k,v| v.is_a? UnknownField }
    end
    @unknown_fields[applicant]
  end

  def known_fields applicant
    @known_fields ||= Hash.new do |h, key|
      h[key] = field_results(key).reject { |k,v| v.is_a? UnknownField }
    end
    @known_fields[applicant]
  end

  def filled_fields applicant
    @filled_fields ||= Hash.new do |h, key|
      h[key] = known_fields(key).reject { |k,v| v.blank? }
    end
    @filled_fields[applicant]
  end
end
