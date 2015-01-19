require 'test_helper'

class FormIntegrationTest < ActionDispatch::IntegrationTest
  # This prevents database errors caused by Capybara's javascript drivers
  self.use_transactional_fixtures = false

  def setup
    Capybara.current_driver = Capybara.javascript_driver
  end

  # https://github.com/codefordc/districthousing/issues/172
  def test_go_through_blank_form
    login_as(users(:one), scope: :user)
    visit('/')
    click_on('Create a new applicant')
    assert_equal(new_applicant_path, current_path)
    click_on('Get started')
    assert_equal(200, page.status_code)
    click_on('Save and continue')
    assert_equal(200, page.status_code)
    click_on('Save and continue')
    assert_equal(200, page.status_code)
    click_on('Save and continue')
    assert_equal(200, page.status_code)
    click_on('Save and continue')
    assert_equal(200, page.status_code)
  end

end
