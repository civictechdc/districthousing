class Employment < ActiveRecord::Base
  include Progress
  include FindIndex
  
  part_of :employments
  progress_includes :address

  belongs_to :person
  belongs_to :address
  accepts_nested_attributes_for :address

  def to_s
    "Employment at #{employer_name} from #{start_date} to #{end_date}"
  end
end
