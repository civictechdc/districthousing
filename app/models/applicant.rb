class Applicant < ActiveRecord::Base
  # attr_accessible :title, :body
  #attr_accessible :first_name, :middle_name, :last_name, :ssn, :dob, :gender, :res_street_address, :res_city, :res_state, :res_zip, :res_apt

  attr_accessible :first_name, :last_name
  
  #validates :first_name => true
  #validates :last_name => true
  #validates :dob => true
end
