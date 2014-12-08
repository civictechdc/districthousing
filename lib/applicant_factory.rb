module ApplicantFactory

  class << self

    def make_an_address
      Address.create(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip,
        apt: ["", "#{rand 999}", "Apartment #{rand 999}", "Unit #{('A'..'Z').to_a.sample}"].sample
      )
    end

    def make_a_person(applicant)
      Person.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        middle_name: Faker::Name.first_name,
        ssn: "%s-%s-%s" % [Faker::Number.number(3), Faker::Number.number(2), Faker::Number.number(4)],
        dob: rand(120*365).days.ago,
        gender: ["Female", "Male"].sample,
        work_phone: Faker::PhoneNumber.phone_number,
        home_phone: Faker::PhoneNumber.phone_number,
        cell_phone: Faker::PhoneNumber.phone_number,
        citizenship: Faker::Address.country,
        nationality: Faker::Address.country,
        state_of_birth: Faker::Address.state,
        city_of_birth: Faker::Address.city,
        email: Faker::Internet.email,
        # Sample races from US Census
        # http://www.census.gov/topics/population/race/about.html
        race: ["White", "Black", "American Indian", "Asian", "Pacific Islander"].sample,
        student_status: ["Not a student", "Part-time", "Full-time"].sample,
        marital_status: ["Never married", "Married", "Widowed", "Divorced"].sample,
        occupation: ["Butcher", "Baker", "Candlestick Maker"].sample,
        driver_license_number: Faker::Number.number(10),
        driver_license_state: Faker::Address.state,
      ) do |p|
        p.mail_address = make_an_address
        p.applicant = applicant
      end
    end

    def make_a_residence(applicant)
      Residence.create(
        start: rand(10*365).days.ago,
        end: rand(10*365).days.ago,
        reason: ["Evicted", "Voluntary"].sample
      ) do |r|
        r.address = make_an_address
        r.landlord = make_a_person(applicant)
      end
    end

    def make_a_household_member(applicant)
      HouseholdMember.create(
        relationship: %w(Mother Father Brother Sister Daughter Son Grandfather Grandmother Friend).sample
      ) do |h|
        h.person = make_a_person(applicant)
      end
    end

    def make_an_income
      Income.create(
        income_type_id: IncomeType.all.sample.id,
        amount: rand(1000)
      )
    end

    def make_an_employment
      Employment.create do |e|
        e.start_date = rand(2*365).days.ago
        e.end_date = rand(2*365).days.ago
        e.employer_name = "#{Faker::Company.name} #{Faker::Company.suffix}"
        e.supervisor_name = Faker::Name.name
        e.position = Faker::Name.title
        e.phone = Faker::PhoneNumber.phone_number
        e.address = make_an_address
      end
    end

    def make_a_sex_offense
      CriminalHistory.create(
        year: rand(10*365).days.ago,
      ) do |f|
        f.crime_type = CrimeType.find_by(name: "sex_offense")
      end
    end

    def make_a_felony
      CriminalHistory.create(
        description: [
          "Wearing white after Labor Day.",
          "Tearing the tag off a mattress.",
          "Not keeping off the grass.",
          "Landing on the \"Go directly to jail\" space.",
          "Entering through the \"Exit\" door at the grocery store.",
          "Outsider trading.",
          "Having 11 items in the express checkout lane.",
          "Going 26 in a 25.",
        ].sample,
        year: rand(10*365).days.ago,
      ) do |f|
        f.crime_type = CrimeType.find_by(name: "felony")
      end
    end

    def make_a_sample_applicant
      test_applicant = Applicant.create

      test_applicant.identity = make_a_person(test_applicant)

      3.times { test_applicant.residences << make_a_residence(test_applicant) }
      3.times { test_applicant.household_members << make_a_household_member(test_applicant) }
      3.times { test_applicant.identity.incomes << make_an_income }
      3.times { test_applicant.identity.employments << make_an_employment }
      3.times { test_applicant.identity.criminal_histories << make_a_felony }

      test_applicant.identity.criminal_histories << make_a_sex_offense

      test_applicant.household_members_including_self.each do |p|
        p.incomes << make_an_income
      end

      test_applicant.save

      test_applicant
    end
  end
end
