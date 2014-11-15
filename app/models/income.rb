class Income < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :person
  belongs_to :income_type

  attr_accessible :amount, :income_type_id, :person_id

  def to_s
    "Income of $#{amount} monthly from #{income_type.label}"
  end
end
