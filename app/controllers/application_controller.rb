class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller

  # protect_from_forgery

  before_filter :set_p3p_header_for_third_party_cookies

  before_filter :ensure_authenticated

  helper_method :logged_in?, :app_id

  def ensure_authenticated
    if current_facebook_user
      begin
        current_facebook_user.fetch
        log_in
      rescue Exception => ex
        log_out
      end
    else
      log_out
    end
  end

  def logged_in?
    !!session[:logged_in]
  end

private

  def log_in
    session[:logged_in] = true
  end

  def log_out
    session[:logged_in] = nil

    redirect_to authentication_url
  end

  def app_id
    @app_id ||= Facebooker2.load_facebooker_yaml["app_id"]
  end

  def authentication_url
    "https://www.facebook.com/dialog/oauth?client_id=#{app_id}&redirect_uri=#{root_url}&scope=email,publish_stream"
  end


end
