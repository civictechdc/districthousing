class HousingForm < ActiveRecord::Base
  attr_accessible :name, :uri

  has_many :line_items

  has_and_belongs_to_many :form_fields

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
end
