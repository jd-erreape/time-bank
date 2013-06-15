require 'test_helper'
require 'gravatar_loader'

class GravatarLoaderTest < ActiveSupport::TestCase
  test 'response with not valid params' do
    assert_equal GravatarLoader.gravatar_url({}), ''
  end

  test 'basic gravatar url with email' do
    assert_equal GravatarLoader.gravatar_url({email: 'test@test.com'}), gravatar_url('test@test.com')
  end

  test 'gravatar url with default url' do
    assert_equal GravatarLoader.gravatar_url({
                                                 email: 'test@test.com',
                                                 default_url: 'http://avatar.jpg'
                                             }),
                 gravatar_url_with_default_url('test@test.com', 'http://avatar.jpg')
  end

  test 'gravatar url with size' do
    assert_equal GravatarLoader.gravatar_url({
                                                 email: 'test@test.com',
                                                 size: 200
                                             }),
                 gravatar_url_with_size('test@test.com', 200)
  end

  test 'gravatar url with default url and size' do
    assert_equal GravatarLoader.gravatar_url({
                                                 email: 'test@test.com',
                                                 size: 200,
                                                 default_url: 'http://avatar.jpg'
                                             }),
                 gravatar_url_with_size_and_default_url('test@test.com', 200, 'http://avatar.jpg')
  end

  def gravatar_url(email)
    "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(email).downcase}.png"
  end

  def gravatar_url_with_size(email, size)
    "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(email).downcase}.png?s=#{size}"
  end

  def gravatar_url_with_default_url(email, default_url)
    "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(email).downcase}.png?d=#{CGI.escape(default_url)}"
  end

  def gravatar_url_with_size_and_default_url(email, size, default_url)
    "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(email).downcase}.png?s=#{size}&d=#{CGI.escape(default_url)}"
  end
end
