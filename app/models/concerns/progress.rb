module Progress
  extend ActiveSupport::Concern

  def completeness
    filled_field_count * 100 / field_count
  end

  def field_count
    fillable_fields.count
  end

  def filled_field_count
    fillable_fields.reject { |f| send(f).blank? }.count
  end

  def fillable_fields
    attribute_names.reject { |a|
      %w(created_at updated_at applicant_id id address_id).include? a
    }
  end
end
