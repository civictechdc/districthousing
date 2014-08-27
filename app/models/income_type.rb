class IncomeType < ActiveRecord::Base
  attr_accessible :name, :label, :active
  has_many :incomes 
end
