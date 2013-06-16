require 'test_helper'
require 'mocha/setup'

class AvatarTest < ActiveSupport::TestCase
  test 'get empty avatar' do
    user = stub(:email => nil, :avatar_url => nil)
    avatar = Avatar.new(user)
    assert_equal avatar.avatar_url, Avatar::AVATAR_DEFAULT_URL
  end

  test 'get url avatar if no email present' do
    user = stub(:email => nil, :avatar_url => 'http://avatar.jpg')
    avatar = Avatar.new(user)
    assert_equal avatar.avatar_url, 'http://avatar.jpg'
  end

  test 'get url avatar if email present' do
    user = stub(:email => 'test@test.com', :avatar_url => 'http://avatar.jpg')
    avatar = Avatar.new(user)
    assert_equal avatar.avatar_url, 'http://avatar.jpg'
  end

  test 'get gravatar avatar' do
    user = stub(:email => 'test@test.com', :avatar_url => nil)
    avatar = Avatar.new(user)
    assert_equal avatar.avatar_url, gravatar_url(user.email)
  end

  def gravatar_url(email)
    "http://gravatar.com/avatar/#{Digest::MD5::hexdigest(email).downcase}.png?d=#{CGI.escape(Avatar::AVATAR_DEFAULT_URL)}"
  end
end

