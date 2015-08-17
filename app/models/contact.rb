class Contact < ActiveRecord::Base
  include Progress
  include FindIndex

  progress_includes :person
  part_of :contacts

  belongs_to :applicant
  belongs_to :person

  before_validation :initialize_contact
  validates :applicant, :person, presence: true
  validates_associated :person
  
  CONTACT_TYPES = [
    {
      name: "Emergency Contact",
      value: "emergency_contact"
    },
    {
      name: "Reference",
      value: "reference"
    },
    {
      name: "General Contact",
      value: "general_contact"
    }
  ]
  
  validates :contact_type, inclusion: {in: CONTACT_TYPES.map {|ct| ct[:value]}}, allow_nil: true

  accepts_nested_attributes_for :person

  def initialize_contact
    self.person ||= Person.new
  end

  def value_for_field field_name
    case field_name
    when "Relationship"
      relationship
    else
      person.value_for_field field_name
    end
  end

  def to_s
    person.to_s
  end
end
