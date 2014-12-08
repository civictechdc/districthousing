class Employment < ActiveRecord::Base
  include Progress

  progress_includes :address

  belongs_to :person
  belongs_to :address
  accepts_nested_attributes_for :address

  def to_s
    "Employment at #{employer_name} from #{start_date} to #{end_date}"
  end
end
