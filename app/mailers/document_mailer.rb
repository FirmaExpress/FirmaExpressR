class DocumentMailer < ActionMailer::Base
  def signed_by(owner, signer, document)
    @owner = owner
    @signer = signer
    @document = document
    mail(to: owner.email, subject: "#{signer.first_name} ha firmado #{document.name}")
  end
  def everybody_signed(document, participants)
    @document = document
    participants.each do |participant|
      @participant = participant
      mail(to: participant.email, subject: "Todos han firmado   #{document.name}")
    end
  end
end