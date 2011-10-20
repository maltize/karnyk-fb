require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    Message.any_instance.stubs(:client).returns(true)
    Message.any_instance.stubs(:publish_to_fb).returns(true)
  end

  def test_valid
    assert messages(:one).valid?
  end

end
