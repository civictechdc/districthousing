class HousingForm < ActiveRecord::Base
  has_and_belongs_to_many :form_fields
  has_and_belongs_to_many :applicants

  after_create { initialize_from_disk! }
  after_update { read_fields! }

  geocoded_by :location
  # FIXME: On `rake pull_pdfs`, #geocode gets called twice per form.  Why?
  after_validation :geocode, if: :location_changed?

  def initialize_from_disk!
    update(name: name)
    read_fields!
    detect_location!
  end

  def to_s
    name.to_s
  end


  def read_fields!
    form_fields.destroy_all
    unless path.nil?
      PDF_FORMS.get_field_names(path).each do |field_name|
        form_fields << FormField.find_or_create_by(name: field_name)
      end
    end
  end

  def detect_location!
    unless path.nil?
      metadata_output = PDF_FORMS.call_pdftk(path, "dump_data")
      if /InfoKey: Location\nInfoValue: (.+)\n/.match(metadata_output)
        update(location: $1)
      end
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

  def download_path
    unless path.blank?
      path.sub("#{Rails.root}", "").sub!(/\/?public/, "")
    else
      nil
    end
  end

  def as_json options = nil
    h = self.attributes
    h["url"] = download_path
    h.delete("path")
    h
  end

  def is_external?
    if path =~ /external/
      true
    else
      false
    end
  end
end
