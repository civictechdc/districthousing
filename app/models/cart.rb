class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  # Prevent duplicates of the same housing from from being added to the cart
  def add_housing_form(housing_form_id)
    current_item = line_items.find_by_housing_form_id(housing_form_id)
    if ! current_item
      current_item = line_items.build(housing_form_id: housing_form_id)
    end
    current_item
  end

end
