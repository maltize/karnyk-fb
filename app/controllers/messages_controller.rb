# encoding: utf-8
class MessagesController < ApplicationController

  before_filter :load_friends, :only => [:show, :new, :create]

  def login
  end

  def show
    @message = Message.where(:target_fb_user_id => current_facebook_user.id).first
    if @message
      @messages = Message.where(:target_fb_user_id => current_facebook_user.id).where(['id != ?', @message.id]).order("id DESC").paginate(
        :page => params[:page], :per_page => 5
      )
      @messages_count = @messages.count + 1
    else
      @message = Message.new
      flash[:error] = "Nie otrzymałeś jeszcze żadnego Karnego Kutasa."
      render :action => "new"
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.fb_user_id = current_facebook_user.id
    @message.client = current_facebook_client

    if @message.save
      UserMailer.notify_copy(@message).deliver
      flash[:notice] = "Karny Kutas został poprawnie wysłany."
      redirect_to new_message_path
    else
      flash[:error] = "Karny kutas nie wysłany! popraw formularz."
      render :action => "new"
    end
  end

private

  def load_friends
    @friends = current_facebook_user.friends
  end

end
