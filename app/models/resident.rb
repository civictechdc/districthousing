require 'dragoman'

class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn

  belongs_to :user
  has_many :carts

  def form_field_hash targets
    d = Dragoman.new
    d.learn(/FirstName/, ->(first_name) { first_name })
    d.learn(/LastName/, ->(last_name) { last_name })
    d.learn(/DOB/, ->(dob) { dob })
    d.learn(/SSN/, ->(ssn) { ssn })
    d.learn(/.*/, ->() { "x" })

    d.provider = self

    result = Hash.new
    targets.each do |target|
      result[target] = d.field( target )
    end

    result
  end

  def description
    "#{first_name} #{last_name}"
  end

end
