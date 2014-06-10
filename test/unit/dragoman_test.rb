require "dragoman"

class ConcreteDragoman

  include Dragoman

  attr_accessor :first_name,
    :last_name,
    :phone_number,
    :middle_name

  learn(/FullName.*/,
        ->(first_name, middle_name, last_name) { "#{first_name} #{middle_name} #{last_name}"},
        ->(first_name, last_name) { "#{first_name} #{last_name}"})
  learn(/PhoneNumber/,
        ->(phone_number) { phone_number } )
end

class TestDragoman < ActiveSupport::TestCase
  def setup
    @d = ConcreteDragoman.new
    @d.first_name = "Walter"
    @d.last_name = "White"
  end

  def test_produces_field
    assert_equal "Walter White",  @d.field("FullName")
    assert_equal "Walter White",  @d.field("FullName1")

    @d.middle_name = ""
    assert_equal "Walter White",  @d.field("FullName")

    @d.middle_name = "Hartwell"
    assert_equal "Walter Hartwell White",  @d.field("FullName")
  end

  def test_is_useful_for_unfillable_fields

    # FIXME: It's probably better not to use exceptions for this.
    #assert_raise Dragoman::NoMatchError do
    #  @d.field("No such field")
    #end

    #exception = assert_raise Dragoman::MissingItemsError do
    #  @d.field("PhoneNumber")
    #end

    #assert_equal [:phone_number], exception.missing_items
  end

  def test_shows_required_items
    assert_equal [:first_name, :last_name].to_set, @d.required_items("FullName").to_set
  end

  def test_shows_missing_items
    assert_equal [:phone_number],  @d.missing_items("PhoneNumber")
  end
end
