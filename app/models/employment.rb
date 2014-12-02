class Employment < ActiveRecord::Base
  belongs_to :person
  belongs_to :address
  accepts_nested_attributes_for :address

  def to_s
    "Employment at #{employer_name} from #{start_date} to #{end_date}"
  end
end
