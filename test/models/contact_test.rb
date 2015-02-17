require "test_helper"

class ContactTest < ActiveSupport::TestCase

  def contact
    @contact ||= Contact.new
  end

  def test_valid
    contact.applicant = applicants(:one)
    assert contact.valid?, contact.errors.messages
  end

end
