require 'faker'

module ApplicantFactory

  class << self

    def make_an_address
      Address.new(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip: Faker::Address.zip,
        apt: ["", "#{rand 999}", "Apartment #{rand 999}", "Unit #{('A'..'Z').to_a.sample}"].sample
      )
    end

    def make_a_person(applicant)
      Person.new(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        middle_name: Faker::Name.first_name,
        ssn: "%s-%s-%s" % [Faker::Number.number(3), Faker::Number.number(2), Faker::Number.number(4)],
        dob: rand(120*365).days.ago,
        gender: ["Female", "Male"].sample,
        work_phone: Faker::PhoneNumber.phone_number,
        home_phone: Faker::PhoneNumber.phone_number,
        cell_phone: Faker::PhoneNumber.phone_number,
        citizenship: ["US Citizen", "Non-Citizen with eligible immigration status", "Other"].sample,
        country_of_birth: Faker::Address.country,
        state_of_birth: Faker::Address.state_abbr,
        city_of_birth: Faker::Address.city,
        email: Faker::Internet.email,
        race: Constants::Race.all.sample.name_db,
        ethnicity: Constants::Ethnicity.all.sample.name_db,
        student_status: ["Not a student", "Part-time", "Full-time"].sample,
        marital_status: ["Single", "Separated", "Married", "Widowed", "Divorced"].sample,
        occupation: ["Butcher", "Baker", "Candlestick Maker"].sample,
        driver_license_number: Faker::Number.number(10),
        driver_license_state: Faker::Address.state_abbr,
        driver_license_exp_date: Faker::Date.forward(10*365),
      ) do |p|
        p.mail_address = make_an_address
        p.applicant = applicant
      end
    end

    def make_a_residence(applicant)
      Residence.create(
        start: rand(10*365).days.ago,
        end: rand(10*365).days.ago,
        reason: ["Evicted", "Voluntary"].sample,
        rent: rand(900) + 100
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

    def make_a_contact(applicant)
      Contact.create(
        relationship: %w(Mother Father Brother Sister Daughter Son Grandfather Grandmother Friend).sample
      ) do |h|
        h.person = make_a_person(applicant)
      end
    end

    def make_an_income
      Income.new(
        income_type: Constants::IncomeType.all.sample.name_db,
        amount: rand(1000),
        interval: ['weekly', 'monthly', 'yearly'].sample,
      )
    end

    def make_an_employment
      Employment.new do |e|
        e.start_date = rand(2*365).days.ago
        e.end_date = rand(2*365).days.ago
        e.employer_name = "#{Faker::Company.name} #{Faker::Company.suffix}"
        e.supervisor_name = Faker::Name.name
        e.position = Faker::Name.title
        e.phone = Faker::PhoneNumber.phone_number
        e.address = make_an_address
      end
    end

    def make_a_felony
      CriminalHistory.new(
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
        crime_type: Constants::CrimeType.all.sample.name_db,
        year: rand(100) + 1900,
      )
    end

    def make_a_sample_applicant user
      Applicant.create do |a|
        a.user = user
        a.identity = make_a_person(a)
        3.times { a.residences << make_a_residence(a) }
        3.times { a.identity.criminal_histories << make_a_felony }
        3.times { a.identity.incomes << make_an_income }
        3.times { a.identity.employments << make_an_employment }
        3.times { a.household_members << make_a_household_member(a) }
        3.times { a.contacts << make_a_contact(a) }

        a.household_members_including_self.each do |p|
          p.incomes << make_an_income
        end
      end
    end
  end
end
