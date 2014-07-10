class DocumentMailer < ActionMailer::Base
  def signed_by(owner, signer, document)
    @owner = owner
    @signer = signer
    @document = document
    mail(from: 'contacto@firmaexpress.com', to: owner.email, subject: "#{signer.first_name} ha firmado #{document.name}")
  end
  def everybody_signed(document, participant)
    @document = document
    @participant = participant
    mail(from: 'contacto@firmaexpress.com', to: participant.email, subject: "Todos han firmado #{document.name}")
  end
end