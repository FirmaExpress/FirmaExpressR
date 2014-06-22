module API
	class SignsController < APIController
		before_filter :participant

		def participant
			@participant = Participant.find_by(user_id: params[:user_id], document_id: params[:document_id])
		end

		def index
			sign = @participant.sign
			render json: sign, status: :ok
		end

		def create
			#curl -i -X POST -d methods[0][id]=1' http://api.firmaexpress.dev/users/1/documents/1/signs
			#Must check if the given methods are the same as the required by the doc's security level
			if @participant.sign.blank?
				sign = Sign.new
				params[:methods].each do |key, method|
					sign.sign_security_methods << SignSecurityMethod.find(method[:id])
				end
				sign.save
				@participant.sign = sign
				render json: sign, status: :created
			else
				render json: "El archivo ya ha sido firmado", status: :unprocessable_entity
			end
		end
	end
end