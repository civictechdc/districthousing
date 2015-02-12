class Income < ActiveRecord::Base
  include Progress
  include FindIndex

  part_of :incomes

  def applicant
    person.applicant
  end

  belongs_to :person

  def to_s
    unless source.blank?
      "Income of $#{amount.to_i} #{interval} from #{source}"
    else
      "Income of $#{amount.to_i} #{interval}"
    end
  end

  def source
    return "" if income_type.nil?
    Constants::IncomeType.new(income_type).name_form
  end
end
