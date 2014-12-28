class SalesforceApplicant < ActiveRecord::Base
  belongs_to :applicant
  validates :applicant, presence: true
end
