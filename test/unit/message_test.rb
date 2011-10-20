require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    Message.any_instance.stubs(:client).returns(true)
    Message.any_instance.stubs(:publish_to_fb).returns(true)
  end

  def test_valid
    assert messages(:one).valid?
  end

  def test_validate_target_fb_user
    messages(:one).target_fb_user_id = 0

    assert !messages(:one).valid?
    assert messages(:one).errors[:target_fb_user_id]
  end

end
