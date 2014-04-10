class UserMailer < ActionMailer::Base

  def invitation_email(emails)
  	@url = 'http://firmaexpress.com/register'
  	mail(to: emails, subject: 'Invitación a Documento')
  end

  def contact_email (name, email, message)
  	@url = 'http://firmaexpress.com/contact'
  	@name = name
  	@email = email
  	@message = message
  	mail(to: "firmaexpress2014@gmail.com", subject: 'Consulta sobre firmaexpress')
  end

end
