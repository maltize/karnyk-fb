class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller

  # protect_from_forgery

  before_filter :set_p3p_header_for_third_party_cookies

  before_filter :ensure_authenticated

  helper_method :logged_in?

  def ensure_authenticated
    if current_facebook_user
      begin
        current_facebook_user.fetch
        log_in
      rescue Exception => ex
        log_out
      end

      # test_post
    end
  end

  def test_post
    # post = Mogli::Post.new
    # post.message = "Just a test message from API"

    client = current_facebook_client

    # me = Mogli::User.find("me", client)
    # friend = current_facebook_user.friends[0]
    friend_id = 100000472515345 # Zabka

    # client.post("#{friend_id}/feed", nil, :message => "Just a test message from API")
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
  end

end
