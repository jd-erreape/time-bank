require 'integration_test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

  test 'layout header' do
    visit '/'
    assert page.has_content?('Time Bank')
  end

  test 'FB login button exists' do
    visit '/'
    assert page.has_selector? 'a', text: 'Sign in with Facebook'
  end

  test 'FB login through sign_in link' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock :facebook, uid: 'fb-12345', provider: 'facebook', info: {email: 'bob_smith@test.com'}, extra: {raw_info: { name: 'Bob Smith' }}

    visit '/'
    click_link 'Sign in with Facebook'

    assert page.has_content?('Welcome Bob Smith!')
  end

end