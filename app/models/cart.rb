#require 'zip/zip'
require 'net/http'

class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :applicant

  attr_accessible :applicant_id

  # Prevent duplicates of the same housing from from being added to the cart
  def add_housing_form(housing_form_id)
    current_item = line_items.find_by_housing_form_id(housing_form_id)
    if ! current_item
      current_item = line_items.build(housing_form_id: housing_form_id)
    end
    current_item
  end

  def forms
    line_items.map(&:housing_form)
  end

end
