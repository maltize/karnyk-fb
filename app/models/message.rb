# encoding: utf-8
class Message < ActiveRecord::Base

  attr_accessor :client

  validates_presence_of :fb_user_id, :target_fb_user_id, :body, :client

  validates_length_of :body, :minimum => 4, :maximum => 140

  after_create :publish_to_fb

  def fb_user
    Mogli::User.find(fb_user_id)
  end

  def target_fb_user
    Mogli::User.find(target_fb_user_id)
  end

private

  def publish_to_fb
    message = "#{fb_user.name} wysłał Ci Karnego K. Sprawdź tutaj #{Settings.app_url}"

    # 100000707733190 maciek
    # use target_fb_user_id
    client.post("#{100000707733190}/feed", nil, :message => message)
  end

  # http://graph.facebook.com/100000707733190/picture
  # <%= fb_profile_pic(user.fb_user_uid, {:size => 'square' }) %>

end
