class CriminalHistory < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :person
end
