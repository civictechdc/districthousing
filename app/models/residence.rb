class Residence < ActiveRecord::Base
  include Progress

  progress_includes :landlord
  progress_includes :address

  belongs_to :applicant
  belongs_to :address
  belongs_to :landlord, class_name: "Person"

  accepts_nested_attributes_for :landlord

  accepts_nested_attributes_for :address

  validates_associated :address, :landlord

  def self.make_a_residence
    create do |r|
      r.landlord = Person.make_a_person
      r.address = Address.create
    end
  end

  def to_s
    "Residence from #{start} - #{self.end}"
  end

end
