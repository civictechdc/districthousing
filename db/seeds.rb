# Load information from all PDFs in public/forms
HousingForm.delete_all
FormField.delete_all

HousingForm.transaction do
  FormField.transaction do
    Dir.glob(Rails.root.join("public/forms/*.pdf")) do |pdf_path|
      HousingForm.create(uri: pdf_path)
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
IncomeType.destroy_all
Employment.destroy_all
CriminalHistory.destroy_all
CrimeType.destroy_all

# Populate income_types
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

# Populate crime types
CrimeType.create(name: "felony", label: "Felony")
CrimeType.create(name: "sex_offense", label: "Sex Offense")
CrimeType.create(name: "evicted_from_residence", label: "Evicted from your residence")
CrimeType.create(name: "evicted_from_residence_for_drugs", label: "Evicted from your residence because of drug or stubstance abuse")

# Seed a test user
test_user = User.create(
  :email => "testuser@districthousing.org",
  :password => "password"
)

ApplicantFactory.make_a_sample_applicant(test_user)

sample_user = User.create(
  :email => "sampleuser@districthousing.org",
  :password => "password"
)
sample_user.role = User::USER_ROLES[:sample]
sample_user.save!

ApplicantFactory.make_a_sample_applicant(sample_user)
