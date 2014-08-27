class Income < ActiveRecord::Base
  belongs_to :household_member
  belongs_to :income_type
  attr_accessible :amount
end
