class Income < ActiveRecord::Base
  include Progress

  belongs_to :applicant
  belongs_to :person
  belongs_to :income_type

  def to_s
    unless source.blank?
      "Income of $#{amount.to_i} #{interval} from #{source}"
    else
      "Income of $#{amount.to_i} #{interval}"
    end
  end

  def source
    return "" if income_type.nil?
    income_type.label
  end
end
