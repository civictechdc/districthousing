class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn
end
