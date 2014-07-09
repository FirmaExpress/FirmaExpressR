class ParticipantsController < ApplicationController
	before_action :authenticate_user!

	def destroy
=begin
		participant_id = params[:id].to_i
		participant = Participant.find(participant_id)
		status = participant.destroy
=end
		user_id = params[:user_id].to_i
		document_id = params[:document_id].to_i
		user = User.find user_id
		document = user.documents.find document_id
		status = document.destroy
		respond_to do |format|
			format.json { render :json => status }
		end
	end
end



