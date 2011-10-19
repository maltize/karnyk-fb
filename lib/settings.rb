class Settings

  class << self

    def app_id
      @app_id ||= Facebooker2.load_facebooker_yaml["app_id"]
    end

    def app_url
      "http://apps.facebook.com/karny-kutas/"
    end

    def auth_url
      "https://www.facebook.com/dialog/oauth?client_id=#{app_id}&redirect_uri=#{CGI::escape(app_url)}&scope=publish_stream"
    end

  end

end
