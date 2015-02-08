ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require 'mocha/mini_test'
require 'fake_intake'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Capybara.default_wait_time = 15

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 15)
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Allow signins with warden
  include Warden::Test::Helpers
  Warden.test_mode!
end

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActiveSupport::TestCase
    ActiveRecord::Migration.check_pending!

    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # This will verify that multiple attributes of a fixture were changed in
  # the database, such as after a call to #update.
  def assert_attributes_were_updated model_from_fixture, attribute_list
    updated_model = model_from_fixture.class.find(model_from_fixture.id)
    attribute_list.each do |k|
      assert_not_nil(updated_model.attributes[k.to_s],
        "Failure for attribute #{k}")
      assert_not_equal(model_from_fixture.attributes[k.to_s], updated_model.attributes[k.to_s],
        "Failure for attribute #{k}")
    end
  end

end
