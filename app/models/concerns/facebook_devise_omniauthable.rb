module FacebookDeviseOmniauthable
  extend ActiveSupport::Concern

  included do
    devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :google]
  end

  module ClassMethods
    def find_for_facebook_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
        )
      end
      user
    end

    def find_for_twitter_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:"#{auth.extra.raw_info.name}@gmail.com",
                           password:Devise.friendly_token[0,20]
        )
      end
      user
    end

    def find_for_open_id(access_token, signed_in_resource=nil)
      data = access_token.info
      if user = User.where(:email => data['email']).first
        user
      else
        User.create!(:email => data['email'], :password => Devise.friendly_token[0,20])
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end

end