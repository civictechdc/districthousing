class AddressTest < ActiveSupport::TestCase

  test "is flexible in generating a full address" do
    @test = Address.new street: "123 Fake Street"
    assert_equal "", @test.full

    @test.city = "Toon Town"
    assert_equal "123 Fake Street, Toon Town", @test.full

    @test.state = "Lemuria"
    assert_equal "123 Fake Street, Toon Town, Lemuria", @test.full

    @test.zip = "24601"
    assert_equal "123 Fake Street, Toon Town, Lemuria, 24601", @test.full

    @test.apt = "2"
    assert_equal "123 Fake Street, #2, Toon Town, Lemuria, 24601", @test.full

    @test.apt = "2B"
    assert_equal "123 Fake Street, #2B, Toon Town, Lemuria, 24601", @test.full

    @test.apt = "AbCdE"
    assert_equal "123 Fake Street, AbCdE, Toon Town, Lemuria, 24601", @test.full

    @test.apt = "123"
    assert_equal "123 Fake Street, #123, Toon Town, Lemuria, 24601", @test.full

    @test.apt = "Unit 2"
    assert_equal "123 Fake Street, Unit 2, Toon Town, Lemuria, 24601", @test.full
  end

  test "says homeless when street has the word homeless in it" do
    @homeless = Address.new street: "Homeless"
    assert_equal "Homeless", @homeless.full 

    @homeless_2 = Address.new street: "Was homeless"
    assert_equal "Homeless", @homeless_2.full 
  end
end
