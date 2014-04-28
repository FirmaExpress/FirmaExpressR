class UsersController < ApplicationController
	before_action :authenticate_user!
	#before_action :check_auth, only: [:profile, :invite]
	def new
		@user = User.new
		user_id = params[:u]
		code = params[:c]
		if user_id
			@user = User.find(user_id)
		end
		if code
			@user.invite_code = code
		end
	end

	def create
		uploaded_io = params[:user][:avatar]
		first_name = params[:user][:first_name]
		last_name = params[:user][:last_name]
		email = params[:user][:email]
		password = params[:user][:password]
		password_confirmation = params[:user][:password_confirmation]
		id_number = params[:user][:id_number]
		invitation_code = params[:user][:invite_code]

		@user = User.new(avatar: uploaded_io.original_filename, first_name: first_name, last_name: last_name, id_number: id_number, email: email, password: password, password_confirmation: password_confirmation, user_type_id: 3, invite_code: invitation_code)
		if @user.save
			3.times do
				@user.invite_codes << InviteCode.create()
			end
			dir = 'uploads/users/' + @user.id.to_s() + '/'
			avatar_path = dir + uploaded_io.original_filename
			@user.avatar = avatar_path
			@user.save
			FileUtils.mkdir_p('public/' + dir) unless File.directory?(dir)
			File.open(Rails.root.join('public', avatar_path), 'wb') do |file|
				file.write(uploaded_io.read)
			end
			redirect_to root_url, :notice => "Registrado!"
		else
			render "new"
		end
	end

	def invite
		emails = params[:e]
		document_id = params[:d]
		invitation_type = params[:t]
		users = []
		emails.split(',').each do |email|
			if invitation_type == 'participant'
				user = User.where('"email" = \'' + email + '\'').first
				unless user
					#Pendiente: Implementar validación diferida según endpoint	
					user = User.new(avatar: 'uploads/user.jpg', email: email, password: email, password_confirmation: email)
					type = UserType.find(2)
					user.user_type = type
					user.save
				end
				document = Document.find(document_id)
				if document
					if Participant.where('"document_id" = ' + document.id.to_s + ' AND "user_id" = ' + user.id.to_s).exists? == false
						participant = Participant.new(document_id: document.id, role_id: 2, user_id: user.id, signed: 'f')
						participant.save
						UserMailer.invitation_email(user, document).deliver
					end
				end
				users << user
			elsif invitation_type == 'free'
				if @invitations_left.count > 0 and !User.exists?(email: email)
					@url = 'http://firmaexpress.com/register?c=' + @invitations_left.first.code
					@code = @invitations_left.first.code
					UserMailer.free_user_invitation_email(@current_user, email, @invitations_left.first).deliver
				end
			end
			respond_to do |format|
				format.json { render :json => [message: "Invitaciones enviadas a " + emails, users: users] }
			end
		end
	end

	def contact
        name = params[:name]
        email = params[:email]
        message = params[:message]
        UserMailer.contact_email(name, email, message).deliver
        redirect_to root_url
    end

    def update_profile
    	campo = params[:campo]
		valor = params[:valor]
		id = current_user.id
		boolean = []
		user = User.find(id)
		case campo
			when "first_name" 
				user.first_name = valor
			when "last_name"
				user.last_name = valor
			when "email"
				user.email = valor
		end
		save_status = user.save
		respond_to do |format|
			format.json { render :json => [errors: user.errors, save_status: save_status] }
		end
    end

    def profile
    	respond_to do |format|
			format.html
			format.json { render :json => current_user }
		end
    end
end
