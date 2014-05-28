class Address < ActiveRecord::Base
  attr_accessible :street, :city, :state, :zip
  has_many :residents, class_name: :person, through: :person, source: :residence

  def full
    "#{street}, #{city}, #{state}, #{zip}"
  end
end
