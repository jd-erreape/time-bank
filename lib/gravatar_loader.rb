require 'uri'

module GravatarLoader
  BASIC_URL = 'http://gravatar.com/avatar'

  def self.gravatar_url(params)
    loaded_url = ''
    begin
      if params[:email]
        loaded_url = compose_basic_url(params[:email])
        loaded_url = add_param(loaded_url,'s',params[:size].to_s) if params[:size]
        loaded_url = add_param(loaded_url,'d',params[:default_url]) if params[:default_url]
      end
    rescue
      ''
    end
    loaded_url
  end

  private

  def self.compose_basic_url(email)
    "#{BASIC_URL}/#{Digest::MD5::hexdigest(email).downcase}.png"
  end

  def self.add_param(url, param_name, param_value)
    uri = URI(url)
    params = URI.decode_www_form(uri.query || []) << [param_name, param_value]
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end
end

