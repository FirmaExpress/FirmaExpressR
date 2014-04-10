class UsersController < ApplicationController
	def new
		@user = User.new
		user_id = params[:u]
		if user_id
			@user = User.find(user_id)
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

		@user = User.new(avatar: uploaded_io.original_filename, first_name: first_name, last_name: last_name, id_number: id_number, email: email, password: password, password_confirmation: password_confirmation)
		type = UserType.find(3)
		@user.user_type = type
		if @user.save
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
		users = []
		emails.split(',').each do |email|
			user = User.where('"email" = \'' + email + '\'').first
			if user == nil
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
		end
		respond_to do |format|
			format.json { render :json => [message: "Invitaciones enviadas a " + emails, users: users] }
		end
	end

	def contact
        name = params[:name]
        email = params[:email]
        message = params[:message]
        UserMailer.contact_email(name, email, message).deliver
        redirect_to root_url
    end
end
