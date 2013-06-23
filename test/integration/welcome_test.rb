require 'integration_test_helper'

class WelcomeTest < ActionDispatch::IntegrationTest

  test 'test example' do
    visit '/'
    assert page.has_content?('IT WORKS!')
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

    assert page.has_content?('Welcome!')
  end

  test 'Twitter login through sign_in link' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock :twitter, uid: 'tw-12345', provider: 'twitter', extra: {raw_info: { name: 'Bob Smith' }}

    visit '/'
    click_link 'Sign in with Twitter'

    assert page.has_content?('Welcome!')
  end

  test 'Google login through sign_in link' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock :google, provider: 'google', info: {email: 'bob_smith@test.com'}

    visit '/'
    click_link 'Sign in with Google'

    assert page.has_content?('Welcome!')
  end

end