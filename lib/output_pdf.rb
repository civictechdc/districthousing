class OutputPDF
  def initialize form, applicant
    @form = form
    @applicant = applicant
  end

  def to_file
    Tempfile.new(@form.name).tap do |temp_file|
      PDF_FORMS.fill_form @form.path, temp_file.path, form_field_hash
    end
  end

  private

  def form_field_hash
    Hash[form_fields.compact]
  end

  def form_fields
    fields.map do |field_name|
      [field_name, @applicant.field(field_name)]
    end
  end

  def fields
    @form.form_fields.map(&:name)
  end
end
