class HouseholdMember < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :person
end
