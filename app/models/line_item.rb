class LineItem < ActiveRecord::Base
  belongs_to :housing_form
  belongs_to :cart

  attr_accessible :cart_id, :housing_form_id
end
