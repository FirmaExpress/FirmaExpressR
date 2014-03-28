class DocumentsController < ApplicationController
	before_action :check_auth
	def new
		@document = Document.new
		user = User.find(session[:user_id])
		@documents = user.documents
	end

	def create
		uploaded_io = params[:document][:path]
		dir = 'uploads/users/' + session[:user_id].to_s() + '/documents/'
		document_path = dir + uploaded_io.original_filename
		document = Document.new(name: uploaded_io.original_filename, path: document_path)
		user = User.find(session[:user_id])
		user.documents << document
		FileUtils.mkdir_p('public/' + dir) unless File.directory?(dir)
		File.open(Rails.root.join('public', dir, uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
		end
		redirect_to root_url
	end

	def show
		@document = Document.find(params[:id])
		user = User.find(session[:user_id])
		@documents = user.documents
		@participants = @document.users
	end
end
