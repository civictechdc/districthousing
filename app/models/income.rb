class Income < ActiveRecord::Base
  #TODO: enable validation (currently 'add' buttons create new, blank entries)
  #validates :amount, presence: true, numericality: {only_integer: true}
  #validates :income_type_id, presence: true
  
  belongs_to :household_member
  belongs_to :income_type
  attr_accessible :amount, :income_type_id
end
