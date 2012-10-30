require 'action_mailer'

# http://stackoverflow.com/questions/4951310/actionmailer-3-without-rails
# http://www.codeography.com/2010/03/24/simple-capistrano-email-notifier-for-rails.html

ActionMailer::Base.delivery_method = :sendmail #:smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address        => 'localhost',
  :port           => 25,
  :domain         => 'retrodict.com'#,
#  :perform_deliveries => true,
#  :user_name      => 'user',
#  :password       => 'secret',
#  :authentication => :login 
}

class Notifier < ActionMailer::Base
  def deploy_notification(cap_vars)
    now = Time.now
    # recipients cap_vars.notify_emails
    # from     "App Deployments <app_deployments@example.com>"
    # subject  "Deployed to #{cap_vars.host}"
    # 
    # body <<-MSG
    #   Performed a deploy operation on #{now.strftime("%m/%d/%Y")} at #{now.strftime("%I:%M %p")} to #{cap_vars.host}
    # 
    #   Deployed to: https://#{cap_vars.host}
    # MSG
    mail(:to      => cap_vars.notify_emails,
        :from     => "App Deployments <app@phillbaker.com>",
        :subject  => "Deployed to #{cap_vars.application}") do |format|
          format.text { render :text => <<-MSG
Performed a deploy operation on #{now.strftime("%m/%d/%Y")} at #{now.strftime("%I:%M %p")} to #{cap_vars.application}

See it live at: http://#{cap_vars.application}
MSG
          }
                    
        end
    
  end
end
