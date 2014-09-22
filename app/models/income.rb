class Income < ActiveRecord::Base
  # validate 'amount' as currency
  validates :amount, presence: true, format: {with: /\A(?!0\.00)\d+(\.\d\d)?\z/, message: "Amount is not properly formatted (ex. 250.50)"}
  validates :income_type_id, presence: true
  
  belongs_to :household_member
  belongs_to :income_type
  attr_accessible :amount, :income_type_id
end
