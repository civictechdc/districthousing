module Constants

  # Sample races from US Census
  # http://www.census.gov/topics/population/race/about.html
  class Race
    def self.all
      [
        Race.new("NativeAmerican"),
        Race.new("Asian"),
        Race.new("Black"),
        Race.new("PacificIslander"),
        Race.new("Other"),
        Race.new("White")
      ]
    end

    def initialize db
      @name_db = db
    end

    attr_reader :name_db
    attr_reader :name_form

    def name_pdf
      {
        "NativeAmerican" => "Native American",
        "Asian" => "Asian",
        "Black" => "Black",
        "PacificIslander" => "Pacific Islander",
        "Other" => "Other",
        "White" => "White",
      }[name_db]
    end

    def name_form
      {
        "NativeAmerican" => "American Indian or Alaska Native",
        "Asian" => "Asian",
        "Black" => "Black or African American",
        "PacificIslander" => "Native Hawaiian or Other Pacific Islander",
        "Other" => "Other",
        "White" => "White",
      }[name_db]
    end
  end

end
