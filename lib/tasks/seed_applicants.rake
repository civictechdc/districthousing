# Create a whole lot of fake applicants to test with.

task seed_applicants: :environment do
  # Seed a test user
  test_user = User.create(
    :email => "testuser@districthousing.org",
    :password => "password"
  )

  30.times do
    puts ApplicantFactory.make_a_sample_applicant(test_user)
  end

end
