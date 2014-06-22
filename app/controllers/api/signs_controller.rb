module API
	class SignsController < APIController
		before_filter :participant

		def participant
			@participant = Participant.find_by(user_id: params[:user_id], document_id: params[:document_id])
		end

		def index
			#curl -i -X GET http://api.firmaexpress.dev/users/1/documents/1/signs
			sign = @participant.sign
			render json: sign, status: :ok
		end

		def create
			#curl -i -X POST -d 'methods[0][id]=1' http://api.firmaexpress.dev/users/1/documents/1/signs
			#Must check if the given methods are the same as the required by the doc's security level
			response = nil
			status = nil
			if @participant.sign.blank?
				sign = Sign.new
				params[:methods].each do |key, method|
					input = method[:input]
					security_method = SignSecurityMethod.find(method[:id])
					if (security_method.id == 1 and input == true) or
						(security_method.id == 2 and input == true) or
						(security_method.id == 3 and input == "#{current_user.first_name} #{current_user.last_name}".capitalize)
						sign.sign_security_methods << security_method
						sign.save
						@participant.sign = sign
						response = sign
						status = :created
					else
						response = 'Los datos ingresados son incorrectos'
						status = :unprocessable_entity
					end
				end
			else
				response = "El archivo ya ha sido firmado"
				status = :unprocessable_entity
			end
			render json: response, status: status
		end
	end
end