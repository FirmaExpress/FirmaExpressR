module API
	class DocumentsController < APIController
		def index
			documents = Document.all
			render json: documents, status: :ok
			# respond_to do |format|
			# 	format.json { render json: documents, status: :ok } #200
			# end
		end
	end
end