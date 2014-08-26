class Income < ActiveRecord::Base
  belongs_to :household_member
  attr_accessible :amount, :type
end
