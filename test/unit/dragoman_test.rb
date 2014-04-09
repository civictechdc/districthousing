require "test/unit"

require "ostruct"
require "dragoman"

class TestDragoman < Test::Unit::TestCase
  def setup
    @provider = OpenStruct.new
    @provider.first_name = "Walter"
    @provider.last_name = "White"

    @d = Dragoman.new
    @d.learn(/FullName.*/,
             ->(first_name, middle_name, last_name) { "#{first_name} #{middle_name} #{last_name}"},
             ->(first_name, last_name) { "#{first_name} #{last_name}"})
    @d.learn(/PhoneNumber/,
             ->(phone_number) { phone_number } )
  end

  def test_produces_field
    assert_equal "Walter White",  @d.field("FullName", @provider)
    assert_equal "Walter White",  @d.field("FullName1", @provider)

    @provider.middle_name = ""
    assert_equal "Walter White",  @d.field("FullName", @provider)

    @provider.middle_name = "Hartwell"
    assert_equal "Walter Hartwell White",  @d.field("FullName", @provider)
  end

  def test_is_useful_for_unfillable_fields
    assert_raise Dragoman::NoMatchError do
      @d.field("No such field", @provider)
    end

    exception = assert_raise Dragoman::MissingItemsError do
      @d.field("PhoneNumber", @provider)
    end

    assert_equal [:phone_number], exception.missing_items
  end

  def test_shows_required_items
    assert_equal [:first_name, :last_name].to_set, @d.required_items("FullName").to_set
  end

  def test_shows_missing_items
    assert_equal [:phone_number],  @d.missing_items("PhoneNumber", @provider)
  end
end
