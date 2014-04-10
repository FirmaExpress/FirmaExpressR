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
		participant = Participant.new(document_id: document.id, role_id: 1, user_id: user.id, signed: 'f')
		participant.save
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
		@participants = Document.joins(participants: [{ user: :roles }]).select('"documents".*, "participants".*, "users".*, "roles".name as role').where('"documents"."id" = ' + @document.id.to_s)
		@signed = Document.joins(participants: [{ user: :roles }]).select('"participants"."signed"').where('"participants"."user_id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s).first
		@current_user_role = Document.joins(participants: [{ user: :roles }]).select('"roles"."id","roles"."name"').where('"participants"."user_id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s).first
		respond_to do |format|
			format.html
			format.json { render :json => [participants: @participants, document: @document, signed: @signed.signed, current_user_role: @current_user_role] }
		end
	end

	def sign
		document_id = params[:id]
		user = User.find(session[:user_id])
		user_id = user.id.to_s
		participant = Participant.where('"document_id" = ' + document_id + ' AND "user_id" = ' + user_id).first
		participant.signed = 't'
		participant.save
		redirect_to "/documents/" + document_id
	end

	def destroy
    	@document = Document.find(params[:id])
		@document.destroy
		redirect_to root_url	
    end
end
