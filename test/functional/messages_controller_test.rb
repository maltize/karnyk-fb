require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  def setup
    @friend = Struct::FacebookFriend.new(30, "Kano")
    @user = Struct::FacebookUser.new(10, 'Scorpion', [@friend])
    @user2 = Struct::FacebookUser.new(20, 'Sub-Zero', [@friend])

    Message.any_instance.stubs(:client).returns(true)
    Message.any_instance.stubs(:publish_to_fb).returns(true)
    Message.any_instance.stubs(:fb_user).returns(@user2)
    Message.any_instance.stubs(:target_fb_user).returns(@user)

    @controller.stubs(:logged_in?).returns(true)
    @controller.stubs(:log_out).returns(nil)
    @controller.stubs(:current_facebook_user).returns(@user)

    @message = messages(:one)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create_should_create_message
    assert_difference('Message.count') do
      post :create, :message => @message.attributes
    end

    assert_redirected_to new_message_path
  end

  def test_show_should_show_messages
    get :show

    assert_response :success
    assert_template 'show'
  end

  def test_show_should_render_new_if_no_messages
    @controller.stubs(:current_facebook_user).returns(Struct::FacebookUser.new(12, "Noob", []))

    get :show

    assert_response :success
    assert_template 'new'
  end

end
