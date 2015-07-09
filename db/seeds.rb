Applicant.destroy_all
Person.destroy_all
User.destroy_all
Residence.destroy_all
Address.destroy_all
Income.destroy_all
Employment.destroy_all
CriminalHistory.destroy_all
Contact.destroy_all

sample_user = User.create(
  :email => "sampleuser@districthousing.org",
  :password => "password"
)
sample_user.role = User::USER_ROLES[:sample]
sample_user.save!

a = ApplicantFactory.make_a_sample_applicant(sample_user)
a.identity.first_name = "Sample"
a.identity.middle_name = "Testing"
a.identity.last_name = "Person"
a.save
