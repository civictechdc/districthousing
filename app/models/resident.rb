require 'dragoman'

class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn

  belongs_to :user
  has_many :carts

  def create_dragoman
    d = Dragoman.new
    d.learn(/FirstName/, ->(first_name) { first_name })
    d.learn(/LastName/, ->(last_name) { last_name })
    d.learn(/DOB/, ->(dob) { dob })
    d.learn(/SSN/, ->(ssn) { ssn })
    d.learn(/Phone/, ->(phone) { phone })

    d.provider = self

    d
  end

  def form_field_hash field_names
    d = create_dragoman

    result = Hash.new

    field_names.each do |field_name|
      begin
      result[field_name] = d.field( field_name )
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
    d = create_dragoman

    field_names.map do |field_name|
      begin
        d.missing_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def unrecognized_fields_for field_names
    d = create_dragoman

    field_names.map do |field_name|
      begin
        d.required_items field_name
        nil
      rescue Dragoman::NoMatchError
        field_name
      end
    end.flatten.reject(&:nil?).to_set
  end

  def preferred_attrs_for field_names
    d = create_dragoman

    logger.info "Preferred attrs for: #{field_names.inspect}"

    field_names.map do |field_name|
      begin
        d.preferred_items(field_name)
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set.tap do |o|
      logger.info(o.inspect)
    end
  end
end
