class UserMailer < ActionMailer::Base

  def invitation_email(user, document)
  	@url = 'http://firmaexpress.com/register?u=' + user.id.to_s
  	@user = user
  	@document = document
  	mail(to: user.email, subject: 'Invitación a Documento ' + document.name)
  end
end
