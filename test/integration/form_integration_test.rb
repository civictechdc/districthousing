require 'test_helper'

class FormIntegrationTest < ActionDispatch::IntegrationTest
  # This prevents database errors caused by Capybara's javascript driver
  self.use_transactional_fixtures = false

  def setup
    Capybara.current_driver = Capybara.javascript_driver
  end
 
  # https://github.com/codefordc/districthousing/issues/172
  def test_go_through_blank_form
    login_as(users(:one), scope: :user)
    visit('/')
    click_on('Create New Applicant')
    assert_equal(new_applicant_path, current_path)
    click_on('Submit')
    assert_equal(200, page.status_code)
    assert_match(/identity/, page.current_url)
    click_on('Save and continue')
    assert_equal(200, page.status_code)
    assert_match(/household_members/, page.current_url)
    click_on('Continue')
    assert_equal(200, page.status_code)
    assert_match(/residences/, page.current_url)
    click_on('Continue')
    assert_equal(200, page.status_code)
    assert_match(/employments/, page.current_url)
    click_on('Continue')
    assert_equal(200, page.status_code)
    assert_match(/incomes/, page.current_url)
    click_on('Continue')
    assert_equal(200, page.status_code)
    assert_match(/criminal_histories/, page.current_url)
    click_on('Continue')
    assert_equal(200, page.status_code)
    assert_match(/applicants/, page.current_url)
  end

end
