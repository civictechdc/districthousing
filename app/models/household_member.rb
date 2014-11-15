class HouseholdMember < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :person
  has_many :incomes

  validates :applicant, :person, presence: true
  validates_associated :person

  accepts_nested_attributes_for :person
  attr_accessible :person_attributes
  attr_accessible :relationship

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

end
