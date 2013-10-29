class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn

  belongs_to :user

  def instance_variable_string_hash *variable_names
    h = Hash.new
    variable_names.each do |attr|
      puts attr
      h["#{attr}"] = instance_variable_get("@#{attr}").to_s
    end
    h
  end

  def attributes_hash
    instance_variable_string_hash self.class.accessible_attributes
  end

end
