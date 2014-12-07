class Income < ActiveRecord::Base
  include Progress

  belongs_to :applicant
  belongs_to :person
  belongs_to :income_type

  def to_s
    unless income_type.nil?
      "Income of $#{amount.to_i} yearly from #{income_type.label}"
    else
      "Income of $#{amount.to_i} yearly"
    end
  end
end
