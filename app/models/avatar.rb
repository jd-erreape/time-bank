# Possible use:
#
# class User
#   def avatar
#     Avatar.new(self).avatar_url
#   end
# end
#
require 'gravatar_loader'

class Avatar
  AVATAR_DEFAULT_URL = 'http://testimage.jpg'

  def initialize(user)
    @user = user
  end

  def avatar_url
    @avatar_url ||= load_avatar(@user)
  end

  private

  def load_avatar(user)
    if user.respond_to?(:avatar_url) && user.avatar_url.present?
      user.avatar_url
    elsif user.respond_to?(:email) && user.email.present?
      gravatar_url(user.email)
    else
      AVATAR_DEFAULT_URL
    end
  end

  # Private: Build a gravatar url given an email
  #
  # email - The email for retrieving the gravatar
  #
  # Returns the url for gravatar.com the 'd' option in the url load a default image if no gravatar is found
  def gravatar_url(email)
    GravatarLoader.gravatar_url({
        email: email,
        default_url: AVATAR_DEFAULT_URL
    })
  end
end