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

  def amount_yearly
    if interval=="weekly"
      amount.to_i*52.0
    elsif interval=="biweekly"
      amount.to_i*26.0
    elsif interval=="monthly"
      amount.to_i*12.0
    else
      amount.to_i
    end
  end

  def amount_monthly
    if interval=="weekly"
      amount.to_i*4.0
    elsif interval=="biweekly"
      amount.to_i*2.0
    elsif interval=="yearly"
      amount.to_i/12.0
    else
      amount.to_i
    end
  end

  def amount_biweekly
    if interval=="weekly"
      amount.to_i*2.0
    elsif interval=="monthly"
      amount.to_i/2.0
    elsif interval=="yearly"
      amount.to_i/26.0
    else
      amount.to_i
    end
  end

  def amount_weekly
    if interval=="biweekly"
      amount.to_i/2.0
    elsif interval=="monthly"
      amount.to_i/4.0
    elsif interval=="yearly"
      amount.to_i/52.0
    else
      amount.to_i
    end
  end

  def dollarize amount
    sprintf('$%.2f', amount)
  end

  def value_for_field field_name
    case field_name
    when "Source"
      income_type
    when /^Amount$/
      dollarize(amount.to_i)
    when "AmountWeekly"
      dollarize(amount_weekly)
    when "AmountBiweekly"
      dollarize(amount_biweekly)
    when "AmountMonthly"
      dollarize(amount_monthly)
    when "AmountYearly"
      dollarize(amount_yearly)
    when "Interval"
      interval
    when /^Earner(\D+)$/
      person.value_for_field $1
    else
      UnknownField.new
    end
  end

end
