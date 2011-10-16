class MessagesController < ApplicationController

  def show
    @message = Message.where(:permalink => params[:permalink]).first
    if @message
      @messages = Message.where(:target_email => @message.target_email).where(['id != ?', @message.id]).order("id DESC").paginate(
        :page => params[:page], :per_page => 20
      )
      @messages_count = @messages.count + 1
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
      # UserMailer.notify(@message).deliver
      # UserMailer.notify_copy(@message).deliver
      flash[:notice] = "Karny Kutas został poprawnie wysłany."
      redirect_to root_path
    else
      flash[:error] = "Karny kutas nie wysłany! popraw formularz."
      render :action => "new"
    end
  end

  def search
    @message = Message.where(:target_email => params[:query].strip).first
    if @message
      @messages = Message.where(:target_email => params[:query].strip).order("id DESC").paginate(:page => params[:page], :per_page => 20)
      @messages_count = @messages.count
    else
      @message = Message.new
      flash[:error] = "Podany email nie otrzymał jeszcze żadnego Karnego Kutasa."
      render :action => "new"
    end
  end

end
