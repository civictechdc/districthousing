module Constants

  # Races from US Census
  # http://www.census.gov/topics/population/race/about.html
  class Race
    def self.all
      [
        Race.new("NativeAmerican"),
        Race.new("Asian"),
        Race.new("Black"),
        Race.new("PacificIslander"),
        Race.new("Other"),
        Race.new("White"),
        Race.new("Decline"),
      ]
    end


    def initialize db
      @name_db = db
    end

    attr_reader :name_db

    def name_pdf
      {
        "NativeAmerican" => "Native American",
        "Asian" => "Asian",
        "Black" => "Black",
        "PacificIslander" => "Pacific Islander",
        "Other" => "Other",
        "White" => "White",
        "Decline" => "Decline to State",
      }[name_db]
    end

    def name_form
      {
        "NativeAmerican" => "American Indian or Alaska Native",
        "Asian" => "Asian",
        "Black" => "Black or African American",
        "PacificIslander" => "Native Hawaiian or Other Pacific Islander",
        "White" => "White",
        "Decline" => "Decline to State",
        "Other" => "Other",
      }[name_db]
    end
  end

  # Ethnicities also from US Census
  class Ethnicity
    def self.all
      [
        Ethnicity.new("Hispanic"),
        Ethnicity.new("NotHispanic"),
        Ethnicity.new("Decline"),
      ]
    end

    def initialize db
      @name_db = db
    end

    attr_reader :name_db

    def name_pdf
      {
        "Hispanic" => "Hispanic or Latino",
        "NotHispanic" => "Not Hispanic or Latino",
        "Decline" => "Decline to State",
      }[name_db]
    end

    def name_form
      name_pdf
    end
  end

  class CrimeType
    def self.all
      [
        CrimeType.new("felony"),
        CrimeType.new("misdemeanor"),
        CrimeType.new("sex_offense"),
        CrimeType.new("simple_assault"),
        CrimeType.new("other"),
      ]
    end


    def initialize db
      @name_db = db
    end

    attr_reader :name_db

    def name_pdf
      {
        "felony" => "Felony",
        "misdemeanor" => "Misdemeanor",
        "sex_offense" => "Sex Offense",
        "simple_assault" => "Simple Assault",
        "other" => "Other",
      }[name_db]
    end

    def name_form
      name_pdf
    end
  end

  class IncomeType
    def self.all
      [
        IncomeType.new("salary"),
        IncomeType.new("military"),
        IncomeType.new("part-time"),
        IncomeType.new("self"),
        IncomeType.new("social_security"),
        IncomeType.new("disability_benefits"),
        IncomeType.new("military"),
        IncomeType.new("veterans_benefits"),
        IncomeType.new("commissions"),
        IncomeType.new("child_support"),
        IncomeType.new("rental"),
        IncomeType.new("stock"),
        IncomeType.new("insurance"),
        IncomeType.new("trust_fund"),
        IncomeType.new("government_assistance"),
        IncomeType.new("cash_gifts"),
        IncomeType.new("workers_compensation"),
        IncomeType.new("severance"),
        IncomeType.new("lottery"),
        IncomeType.new("alimony"),
        IncomeType.new("scholarship"),
      ]
    end

    def initialize db
      @name_db = db
    end

    attr_reader :name_db

    def name_pdf
      {
        "salary" => "Employment Income (Salary/Full-Time)",
        "part-time" => "Employment Income (Part-Time)",
        "self" => "Self-Employment Income",
        "social_security" => "Social Security Income",
        "disability_benefits" => "Disability Benefits",
        "military" => "Military Income",
        "veterans_benefits" => "Veterans Benefits",
        "commissions" => "Commissions",
        "child_support" => "Child Support",
        "rental" => "Rental Income",
        "stock" => "Stock Income",
        "insurance" => "Insurance Income",
        "trust_fund" => "Trust Fund Income",
        "government_assistance" => "TANF/Government Assistance",
        "cash_gifts" => "Cash Gifts",
        "workers_compensation" => "Worker's Compensation",
        "severance" => "Severance",
        "lottery" => "Lottery",
        "alimony" => "Alimony",
        "scholarship" => "Scholarship",
      }[name_db]
    end

    def name_form
      name_pdf
    end
  end

end
