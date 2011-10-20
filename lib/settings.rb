class Settings

  class << self

    def app_id
      @app_id ||= Facebooker2.load_facebooker_yaml["app_id"]
    end

    def app_url
      "http://apps.facebook.com/karny-kutas/"
    end

  end

end
