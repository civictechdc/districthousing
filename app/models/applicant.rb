class Applicant < ActiveRecord::Base
  belongs_to :self, :class_name => "Person"

  def preferred_attrs_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

end
