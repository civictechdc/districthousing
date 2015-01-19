class ActionDispatch::IntegrationTest
  def test_login
    visit('/')
    click_on('Log In')
  end
end
