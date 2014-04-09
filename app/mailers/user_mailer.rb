class UserMailer < ActionMailer::Base

  def invitation_email(emails)
  	@url = 'http://firmaexpress.com/register'
  	mail(to: emails, subject: 'Invitación a Documento')
  end
end
