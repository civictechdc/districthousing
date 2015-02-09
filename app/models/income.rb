class Income < ActiveRecord::Base
  include Progress
  include FindIndex
  
  part_of :incomes
  
  belongs_to :applicant
  belongs_to :person
  belongs_to :income_type

  def to_s
    unless source.blank?
      "Income of $#{amount.to_i} yearly from #{source}"
    else
      "Income of $#{amount.to_i} yearly"
    end
  end

  def source
    return "" if income_type.nil?
    income_type.label
  end
end
