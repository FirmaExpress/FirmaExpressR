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
		document.save
		user = User.find(session[:user_id])
		#user.documents << document
		#user.roles << Role.find(1)
		participant = Participant.new(document_id: document.id, role_id: 1, user_id: user.id)
		participant.save
		#document.users << user
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
		@participants = Document.joins(:participants, :users, :roles).select('"documents".*, "participants".*, "users".*, "roles".name as role').where('"users"."id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s)
		respond_to do |format|
			format.html
			format.json { render :json => [participants: @participants, document: @document] }
		end
	end
end
