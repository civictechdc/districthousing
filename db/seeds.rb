# Load information from all PDFs in public/forms
HousingForm.delete_all
FormField.delete_all

HousingForm.transaction do
  FormField.transaction do
    Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
      HousingForm.create_from_path pdf_path
    end
  end
end

require 'faker'

Applicant.destroy_all
Person.destroy_all
User.destroy_all
Residence.destroy_all
Address.destroy_all
Income.destroy_all

# Seed a test user
test_user = User.create(
  :email => "testuser@districthousing.org",
  :password => "password"
)
test_user.save

def make_an_address
  Address.create(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    apt: ["", "#{rand 999}", "Apartment #{rand 999}", "Unit #{('A'..'Z').to_a.sample}"].sample
  )
end

def make_a_person
  Person.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    middle_name: Faker::Name.first_name,
    ssn: "%s-%s-%s" % [Faker::Number.number(3), Faker::Number.number(2), Faker::Number.number(4)],
    dob: rand(120*365).days.ago,
    gender: ["Female", "Male"].sample,
    phone: Faker::PhoneNumber.phone_number,
    work_phone: Faker::PhoneNumber.phone_number,
    home_phone: Faker::PhoneNumber.phone_number,
    cell_phone: Faker::PhoneNumber.phone_number,
    citizenship: Faker::Address.country,
    nationality: Faker::Address.country,
    email: Faker::Internet.email,
    # Sample races from US Census
    # http://www.census.gov/topics/population/race/about.html
    race: ["White", "Black", "American Indian", "Asian", "Pacific Islander"].sample,
    student_status: ["Not a student", "Part-time", "Full-time"].sample,
    marital_status: ["Never married", "Married", "Widowed", "Divorced"].sample,
    occupation: ["Butcher", "Baker", "Candlestick Maker"].sample,
  ) do |p|
    p.mail_address = make_an_address
  end
end

def make_a_residence
  Residence.create(
    start: rand(10*365).days.ago,
    end: rand(10*365).days.ago,
    reason: ["Evicted", "Voluntary"].sample
  ) do |r|
    r.address = make_an_address
    r.landlord = make_a_person
  end
end

def make_a_household_member
  HouseholdMember.create(
    relationship: %w(Mother Father Brother Sister Daughter Son Grandfather Grandmother Friend).sample
  ) do |h|
    h.person = make_a_person
  end
end

test_applicant = Applicant.create
test_applicant.user = test_user

3.times { test_applicant.residences << make_a_residence }
3.times { test_applicant.household_members << make_a_household_member }

test_applicant.identity = make_a_person

test_applicant.save

#Populate income_types
IncomeType.destroy_all
IncomeType.create(name: "salary", label: "Salary / Full-Time Employment Income", active: true)
IncomeType.create(name: "military", label: "Military Income", active: true)
IncomeType.create(name: "part-time", label: "Part-Time Employment Income", active: true)
IncomeType.create(name: "self", label: "Self-Employment Income", active: true)
IncomeType.create(name: "social_security", label: "Social Security Income", active: true)
IncomeType.create(name: "disability_benefits", label: "Disability Benefits", active: true)
IncomeType.create(name: "military", label: "Military Income", active: true)
IncomeType.create(name: "veterans_benefits", label: "Veterans Benefits", active: true)
IncomeType.create(name: "commissions", label: "Commissions", active: true)
IncomeType.create(name: "child_support", label: "Child Support", active: true)
IncomeType.create(name: "rental", label: "Rental Income", active: true)
IncomeType.create(name: "stock", label: "Stock Income", active: true)
IncomeType.create(name: "insurance", label: "Insurance Income", active: true)
IncomeType.create(name: "trust_fund", label: "Trust Fund Income", active: true)
IncomeType.create(name: "government_assistance", label: "Government Assistance", active: true)
IncomeType.create(name: "cash_gifts", label: "Cash Gifts", active: true)
IncomeType.create(name: "workers_compensation", label: "Worker's Compensation", active: true)
IncomeType.create(name: "severance", label: "Severance", active: true)
IncomeType.create(name: "lottery", label: "Lottery", active: true)
IncomeType.create(name: "alimony", label: "Alimony", active: true)
IncomeType.create(name: "scholarship", label: "Scholarship", active: true)




