class DocumentsController < ApplicationController
	before_action :authenticate_user!, except: [:check]
	before_action :invitations, :invitations_left
	#before_action :check_auth, except: [:check]
	def new
		@document = Document.new
		user = User.find(current_user.id)
		@documents = user.documents
	end

	def create
		unless params[:document][:path]
			redirect_to "new"
		end
		file = params[:document][:path]
		#dir = 'uploads/users/' + current_user.to_s() + '/documents/'
		#document_path = dir + uploaded_io.original_filename
		@document = Document.new(file: file, user_id: current_user.id)
		if @document.save
			@participant = Participant.new(document_id: @document.id, role_id: 1, user_id: current_user.id, signed: 'f')
			if @participant.save
				redirect_to root_url
			else
				render "new"
			end
		else
			render "new"
		end
		#FileUtils.mkdir_p('public/' + dir) unless File.directory?(dir)
		#File.open(Rails.root.join('public', dir, uploaded_io.original_filename), 'wb') do |file|
		#	file.write(uploaded_io.read)
		#end
	end

	def show
		json_response = nil
		if Document.exists?(id: params[:id])
			@document = Document.where(id: params[:id]).first
			user = User.find(current_user.id)
			@documents = user.documents
			#@participants = Document.joins(participants: [{ user: :roles }]).select('"documents".*, "participants".*, "users".*, "roles".namea as role').where('"documents"."id" = ' + @document.id.to_s)
			@participants = Document.joins('INNER JOIN "participants" ON "participants"."document_id" = "documents"."id" 
				INNER JOIN "users" ON "users"."id" = "participants"."user_id" 
				INNER JOIN "roles" ON "roles"."id" = "participants"."role_id" 
				WHERE ("documents"."id" = ' + @document.id.to_s + ')').select('"documents".*, "participants".*, "users".*, "roles".name as role')
			#@signed = Document.joins(:participants, :users, :roles).select('"participants"."signed"').where('"participants"."user_id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s).first
			@signed = Document.joins('INNER JOIN "participants" ON "participants"."document_id" = "documents"."id" 
				INNER JOIN "users" ON "users"."id" = "participants"."user_id" 
				INNER JOIN "roles" ON "roles"."id" = "participants"."role_id" 
				WHERE ("participants"."user_id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s + ')').select('"documents".*, "participants".*, "users".*, "roles".name as role').first
			#@current_user_role = Document.joins(:participants, :users, :roles).select('"roles"."id","roles"."name"').where('"participants"."user_id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s).first
			@current_user_role = Document.joins('INNER JOIN "participants" ON "participants"."document_id" = "documents"."id" 
				INNER JOIN "users" ON "users"."id" = "participants"."user_id" 
				INNER JOIN "roles" ON "roles"."id" = "participants"."role_id" 
				WHERE ("participants"."user_id" = ' + user.id.to_s + ' AND "documents"."id" = ' + @document.id.to_s + ')').select('"roles"."id","roles"."name"').first
			json_response = [participants: @participants, document: @document, signed: @signed.signed, current_user_role: @current_user_role]
		else
			json_response = [message: 'El documento no existe']
		end
		respond_to do |format|
			format.html
			format.json { render json: json_response }
		end
	end

	def list
		user = User.find(current_user)
		documents = user.documents
		respond_to do |format|
			format.json { render :json => documents }
		end
	end

	def check
		@document = Document.find(params[:id])
		#@participants = Document.joins(:participants, :users, :roles).select('"documents".*, "participants".*, "users".*, "roles".name as role').where('"documents"."id" = ' + @document.id.to_s)
		@participants = Document.joins('INNER JOIN "participants" ON "participants"."document_id" = "documents"."id" 
				INNER JOIN "users" ON "users"."id" = "participants"."user_id" 
				INNER JOIN "roles" ON "roles"."id" = "participants"."role_id" 
				WHERE ("documents"."id" = ' + @document.id.to_s + ')').select('"documents".*, "participants".*, "users".*, "roles".name as role')
	end

	def sign
		document_id = params[:id]
		user = User.find(current_user.id)
		user_id = user.id.to_s
		participant = Participant.where('"document_id" = ' + document_id + ' AND "user_id" = ' + user_id).first
		participant.signed = 't'
		participant_save_status = participant.save
		document = Document.find(document_id)
		if document.to_sign == 0
			document.agreed_at = Time.now
			document.save
		end
		respond_to do |format|
			format.json { render :json => [status: participant_save_status, ] }
		end	
	end

	def destroy
    	@document = Document.find(params[:id])
		status = @document.destroy
		respond_to do |format|
			format.json { render :json => status }
		end
    end
end
