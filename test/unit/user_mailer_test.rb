require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    Message.any_instance.stubs(:fb_user).returns(Struct::FacebookUser.new(20, 'Sub-Zero'))
    Message.any_instance.stubs(:target_fb_user).returns(Struct::FacebookUser.new(20, 'Sub-Zero'))
  end

  def test_notify_copy
    message = messages(:one)

    email = UserMailer.notify_copy(message).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [UserMailer::SYSTEM_EMAIL], email.from
    assert_match /#{message.id}/, email.encoded
  end

end
