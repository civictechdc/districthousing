class Residence < ActiveRecord::Base
  belongs_to :applicant, dependent: :destroy
  belongs_to :address
  belongs_to :landlord, class_name: "Person"
end
