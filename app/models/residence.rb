class Residence < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :address
  belongs_to :landlord, class_name: "Person"

  accepts_nested_attributes_for :landlord
  attr_accessible :landlord_attributes

  accepts_nested_attributes_for :address
  attr_accessible :address_attributes

  attr_accessible :reason
  attr_accessible :start
  attr_accessible :end
  attr_accessible :applicant_id
  attr_accessible :address_id
  attr_accessible :landlord_id

  validates_associated :address, :landlord

  def self.make_a_residence
    create do |r|
      r.landlord = Person.make_a_person
      r.address = Address.create
    end
  end

  def description
    "Residence from #{start} - #{self.end}"
  end

end
