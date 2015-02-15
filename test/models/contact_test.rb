require "test_helper"

class ContactTest < ActiveSupport::TestCase

  def contact
    @contact ||= Contact.new
  end

  def test_valid
    assert contact.valid?
  end

end
