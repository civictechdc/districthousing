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
  validates :address, :landlord, presence: true

  before_validation :initialize_residence

  def initialize_residence
    self.landlord ||= Person.new
    self.address ||= Address.new
  end

  def to_s
    "Residence at #{address}"
  end

end
