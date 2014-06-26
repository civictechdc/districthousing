class HouseholdMember < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :person

  accepts_nested_attributes_for :person
  attr_accessible :person_attributes
end
