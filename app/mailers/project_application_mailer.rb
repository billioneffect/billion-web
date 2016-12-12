class ProjectApplicationMailer < ApplicationMailer
  def project_application(form, email)
    @form = form

    mail to: email,
         from: 'hello@billioneffect.com',
         cc: ENV['admin_email'],
         subject: 'New Billion application submitted'
  end
end
