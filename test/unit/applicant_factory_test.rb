class ApplicantFactoryTest < ActiveSupport::TestCase
  def test_create_sample_applicant
    a = ApplicantFactory.make_a_sample_applicant(users :sample)

    assert a.save, a.errors.messages

    assert_equal 3, a.residences.count
    assert_equal 3, a.household_members.count
    assert_equal 3, a.contacts.count
    assert_equal 4, a.identity.incomes.count
    assert_equal 3, a.identity.employments.count
    assert_equal 3, a.identity.criminal_histories.count
    assert_equal 10, a.people.count
  end
end
