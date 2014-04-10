class UserMailer < ActionMailer::Base

  def invitation_email(user, document)
  	@url = 'http://firmaexpress.com/register?u=' + user.id.to_s
  	@user = user
  	@document = document
  	mail(to: user.email, subject: 'Invitación a Documento ' + document.name)
  end

  def contact_email (name, email, message)
  	@url = 'http://firmaexpress.com/contact'
  	@name = name
  	@email = email
  	@message = message
  	mail(to: "firmaexpress2014@gmail.com", subject: 'Consulta sobre firmaexpress')
  end

end
