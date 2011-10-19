class OauthController < ApplicationController

  def new
    session[:at] = nil
    redirect_to authenticator.authorize_url(:scope => 'publish_stream', :display => 'page')
  end

  def create
    mogli_client = Mogli::Client.create_from_code_and_authenticator(params[:code], authenticator)
    session[:at] = mogli_client.access_token
    redirect_to "/"
  end

  def index
    redirect_to new_oauth_path and return unless session[:at]
    user = Mogli::User.find("me", Mogli::Client.new(session[:at]))
    @user = user
    @posts = user.posts
  end

  def authenticator
    @authenticator ||= Mogli::Authenticator.new('117793468245528', 
      'efe27d89e0b5b5769df50072face0e78',
      oauth_callback_url)
  end
end