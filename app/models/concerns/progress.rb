module Progress
  extend ActiveSupport::Concern

  def completeness
    filled_field_count * 100 / field_count
  end

  def field_count
    fillable_fields.count +
      sub_models.reduce(0) { |sum, m| sum + send(m).field_count }
  end

  def filled_field_count
    fillable_fields.reject { |f| send(f).blank? }.count +
      sub_models.reduce(0) { |sum, m| sum + send(m).filled_field_count }
  end

  def fillable_fields
    attribute_names.reject { |a|
      %w(created_at updated_at id ).include?(a) or
        a.end_with? "_id"
    }
  end

  def progress_includes
    []
  end
end
