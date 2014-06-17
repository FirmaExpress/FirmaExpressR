module API
	class SignsController < APIController

		def index
			participant = Participant.find_by(user_id: params[:user_id], document_id: params[:document_id])
			signs = participant.signs
			render json: signs, status: @status
		end
	end
end