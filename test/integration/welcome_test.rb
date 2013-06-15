require 'integration_test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

  test 'test example' do
    visit '/'
    assert page.has_content?('IT WORKS!')
  end

end