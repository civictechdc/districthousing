require "test_helper"

class PersonTest < ActiveSupport::TestCase

  def person
    @person ||= Person.new
  end

  def test_valid
    assert person.valid?, person.errors.messages
  end

end
