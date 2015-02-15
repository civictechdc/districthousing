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
