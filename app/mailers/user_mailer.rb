# Mailers in addition to the Devise mailers
class UserMailer < ActionMailer::Base #TODO this is somewhat duplicative of the devise mailer
  APP = 'Mobyle'
  default :from => Devise.mailer_sender
  
  def welcome_email(user)
    @user = user
    @login_url  = new_user_session_path #"http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to #{APP}")
  end
  
  def newsletter_welcome_email(user)
    @user = user
    @url  = new_user_session_path #"http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to #{APP}")
  end
end
