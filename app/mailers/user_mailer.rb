class UserMailer < ActionMailer::Base

  def invitation_email(user, document)
    @url = if user.id_number
      'http://firmaexpress.com/documents/' + document.id.to_s
    else
    	'http://firmaexpress.com/users/complete_invitee_profile?u=' + user.id.to_s
    end
  	@user = user
  	@document = document
  	mail(to: user.email, subject: 'Invitación a Documento ' + document.name)
  end

  def contact_email (name, email, message)
  	@url = 'http://firmaexpress.com/contact'
  	@name = name
  	@email = email
  	@message = message
  	mail(to: "contacto@firmaexpress.com", subject: 'Consulta sobre firmaexpress')
  end

  def get_plan_email (name, email, message, plan)
    @url = 'http://firmaexpress.com/contact'
    @name = name
    @email = email
    @message = message
    mail(to: "contacto@firmaexpress.com", subject: "Solicitud de plan #{plan.name}")
  end

  def free_user_invitation_email(user, invitee_email, invitation)
    @user = user
    @url = 'http://firmaexpress.com/register?c=' + invitation.code
    @code = invitation.code
    mail(to: invitee_email, subject: user.first_name + ' te invita a Firma Express')
  end

end
