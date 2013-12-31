require "test/unit"

require "dragoman"

class TestDragoman < Test::Unit::TestCase
  def setup
    @provider = OpenStruct.new
    @provider.first_name = "Walter"
    @provider.last_name = "White"
    @d = Dragoman.new
    @d.provider = @provider
  end

  def test_produces_field
    @d.learn(/FullName.*/,
             ->(first_name, middle_name, last_name) { "#{first_name} #{middle_name} #{last_name}"},
             ->(first_name, last_name) { "#{first_name} #{last_name}"})

    assert_equal "Walter White",  @d.field("FullName")
    assert_equal "Walter White",  @d.field("FullName1")

    @provider.middle_name = "Hartwell"

    assert_equal "Walter Hartwell White",  @d.field("FullName")
  end

  # FIXME: Return a set, not an array.
  # FIXME: What does Dragoman do in case of no matching rule?  Raise an exception?
  def test_shows_required_items
    @d.learn(/FullName.*/, ->(first_name, middle_name, last_name) { "#{first_name} #{middle_name} #{last_name}"})
    assert_equal [:first_name, :middle_name, :last_name],  @d.required_items("FullName")
  end

  def test_shows_missing_items
    @d.learn(/FullName.*/, ->(first_name, middle_name, last_name) { "#{first_name} #{middle_name} #{last_name}"})
    assert_equal [:middle_name],  @d.missing_items("FullName")
  end
end
