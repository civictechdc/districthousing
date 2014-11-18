class Employment < ActiveRecord::Base
  belongs_to :person
  belongs_to :address
  accepts_nested_attributes_for :address
end
