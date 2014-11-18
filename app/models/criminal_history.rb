class CriminalHistory < ActiveRecord::Base
  belongs_to :crime_type
end
