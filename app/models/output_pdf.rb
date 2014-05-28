class OutputPDF
  def initialize form, applicant
    @form = form
    @applicant = applicant
  end
  
  def to_file
    Tempfile.new(@form.name).tap do |temp_file|
      PDF_FORMS.fill_form @form.uri, temp_file.path, form_field_hash
    end
  end

private

  def form_field_hash
    Hash[form_fields.compact]
  end
  
  def form_fields
    fields.map do |field_name|
      begin
        [field_name, $field_name_translator.field(field_name, @applicant )]
      rescue Dragoman::MissingItemsError
      rescue Dragoman::NoMatchError
      end
    end
  end
  
  def fields
    @form.form_fields.map(&:name)
  end
end