class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn

  belongs_to :user
  has_many :carts

  def form_field_hash field_names
    result = Hash.new

    field_names.each do |field_name|
      begin
      result[field_name] = $field_name_translator.field( field_name )
      rescue Dragoman::MissingItemsError
      rescue Dragoman::NoMatchError
      end
    end

    result
  end

  def description
    "#{first_name} #{last_name}"
  end

  def missing_attrs_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.missing_items field_name, self
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def unrecognized_fields_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.required_items field_name
        nil
      rescue Dragoman::NoMatchError
        field_name
      end
    end.flatten.reject(&:nil?).to_set
  end

  def preferred_attrs_for field_names
    logger.info "dragoman is: #{$field_name_translator.inspect}"

    field_names.map do |field_name|
      begin
        $field_name_translator.preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set.tap do |o|
      logger.info(o.inspect)
    end
  end
end
