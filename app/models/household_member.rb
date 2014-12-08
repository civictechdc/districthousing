class HouseholdMember < ActiveRecord::Base
  include Progress

  progress_includes :person

  belongs_to :applicant
  belongs_to :person
  has_many :incomes

  validates :applicant, :person, presence: true
  validates_associated :person

  accepts_nested_attributes_for :person

  def self.make_a_household_member
    create do |h|
      h.person = Person.make_a_person
    end
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
