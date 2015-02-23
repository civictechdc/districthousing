# Make a bunch of fake applicants.

require 'faker'

Applicant.destroy_all
Person.destroy_all
User.destroy_all
Residence.destroy_all
Address.destroy_all
Income.destroy_all
Employment.destroy_all
CriminalHistory.destroy_all
CrimeType.destroy_all
Contact.destroy_all

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

30.times do
  ApplicantFactory.make_a_sample_applicant(test_user)
end

sample_user = User.create(
  :email => "sampleuser@districthousing.org",
  :password => "password"
)
sample_user.role = User::USER_ROLES[:sample]
sample_user.save!

ApplicantFactory.make_a_sample_applicant(sample_user)
