class Residence < ActiveRecord::Base
  include Progress
  include FindIndex

  part_of :residences

  progress_includes :landlord
  progress_includes :address

  belongs_to :applicant
  belongs_to :address
  belongs_to :landlord, class_name: "Person"

  accepts_nested_attributes_for :landlord
  accepts_nested_attributes_for :address

  validates_associated :address, :landlord
  validates :address, :landlord, presence: true

  before_validation :initialize_residence

  def delegate_field_to item, field_name
    item && item.value_for_field(field_name) || ""
  end

  def initialize_residence
    self.landlord ||= Person.new
    self.address ||= Address.new
  end

  def to_s
    if current
      "Current residence at #{address}"
    else
      "Residence at #{address}"
    end
  end

  def end_or_current
    if current
      "current"
    else
      send(:end)
    end
  end

  def value_for_field field_name
    case field_name
    when "Start"
      start
    when "End"
      send(:end)
    when "ReasonForMoving"
      reason
    when /^(\D*)$/
      unless ['Start','End','ReasonForMoving'].include?($1)
        delegate_field_to address, $1
      end
    end
  end
end
