class UserMailer < ActionMailer::Base

  SYSTEM_EMAIL = "info@karnykutas.com"

  def notify_copy(message)
    @message = message
    mail(:from => SYSTEM_EMAIL, :to => SYSTEM_EMAIL, :subject => "Facebook KK ##{message.id}")
  end

  def attach_logo
    attachments.inline['kk_logo.gif'] = File.read("#{Rails.root}/public/images/email_logo.gif")    
  end
end