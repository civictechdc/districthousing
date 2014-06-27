class HouseholdMember < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :person

  accepts_nested_attributes_for :person
  attr_accessible :person_attributes

  def value_for_field field_name
    person.value_for_field field_name
  end


end
