class Message < ActiveRecord::Base

  attr_accessor :client

  validates_presence_of :fb_user_id, :target_fb_user_id, :body, :client

  validates_length_of :body, :minimum => 4, :maximum => 140

  after_save :publish_to_fb

private

  def publish_to_fb
    message = body
    target_fb_user_id
    # 100000707733190 maciek
    client.post("#{100000707733190}/feed", nil, :message => message)
  end

end
