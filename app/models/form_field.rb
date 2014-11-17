class FormField < ActiveRecord::Base
  has_and_belongs_to_many :housing_forms
end
