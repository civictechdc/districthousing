module Progress
  extend ActiveSupport::Concern

  def submodels
    self.class.submodels
  end

  def submodel_collections
    self.class.submodel_collections
  end

  included do
    def self.submodels
      @submodels ||= []
    end

    def self.submodel_collections
      @submodel_collections ||= []
    end

    def self.progress_includes sub_model_attribute
      submodels << sub_model_attribute
    end

    def self.progress_includes_collection collection_attribute
      submodel_collections << collection_attribute
    end
  end

  def progress
    # Prevent divide by zero
    if field_count == 0
      return 0
    end

    filled_field_count * 100 / field_count
  end

  def field_count
    fillable_fields.count + submodels_reduce(:field_count) + submodel_collections_reduce(:field_count)
  end

  def filled_field_count
    fillable_fields.reject { |f| send(f).blank? }.count +
      submodels_reduce(:filled_field_count) + submodel_collections_reduce(:filled_field_count)
  end

  def fillable_fields
    attribute_names.reject { |a|
      %w(created_at updated_at id ).include?(a) or
        a.end_with? "_id"
    }
  end

  def submodels_reduce counter_method
    submodels.reduce(0) { |sum, m| sum + send(m).send(counter_method) }
  end

  def submodel_collections_reduce counter_method
    submodel_collections.reduce(0) do |sum, collection_name|
      sum + send(collection_name).reduce(0) do |collection_sum, item|
        collection_sum + item.send(counter_method)
      end
    end
  end

end
