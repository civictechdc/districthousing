class Income < ActiveRecord::Base
  belongs_to :applicant
  belongs_to :person
  belongs_to :income_type

  def to_s
    "Income of $#{amount} yearly from #{income_type.label}"
  end
end
