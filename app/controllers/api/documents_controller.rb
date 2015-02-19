module API
	class DocumentsController < APIController
		#before_action :authenticate_user!, only: [:show]
		before_filter :get_documents, only: [:index]
		before_filter :get_document, only: [:show]

		def get_documents
			@documents = current_user.documents if current_user and (current_user.id == params[:user_id].to_i)
			if @documents
				@status = :ok
			else
				@status = :unauthorized
			end
		end

		def get_document
			@document = current_user.documents.find_by(id: params[:id]) if current_user and (current_user.id == params[:user_id].to_i)
			if @document
				@status = :ok
			else
				@status = :unauthorized
			end
		end

		def index
			render json: @documents, status: @status
		end

		def show
			render json: @document, status: @status
		end
	end
end