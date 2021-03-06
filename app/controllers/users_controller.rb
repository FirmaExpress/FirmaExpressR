class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:complete_invitee_profile, :rut]
	before_action :invitations, :invitations_left
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

	def show
		sign_out :user
		redirect_to user_root_url
	end

	def sign_image
		current_user.update(sign_image: params[:sign_image])
		redirect_to user_root_url
	end

	def rut
		rut = params[:rut].split('-')[0]
		dv = params[:rut].split('-')[1].upcase
		serial = params[:serial].upcase
		name = ''
		rut_sii = ''
		serial_valid = true
		code = 0
		OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_NONE)
		sii_page = Nokogiri::HTML(open("https://zeus.sii.cl/cvc_cgi/stc/getstc?RUT=#{rut}&DV=#{dv}&PRG=STC&OPC=NOR"))
		begin
			rut_sii = name = sii_page.css('html body center')[1].css('table')[0].css('tr')[1].css('td')[1].css('font').text
			code = 200
		rescue Exception => e
			code = 404
		end
		begin
			name = sii_page.css('html body center')[1].css('table')[0].css('tr')[0].css('td')[1].css('font').text.strip.titleize
		rescue Exception => e
			name = ''
		end

		if code == 200
			page = Nokogiri::HTML(open("https://portal.sidiv.registrocivil.cl/usuarios-portal/pages/DocumentRequestStatus.xhtml?RUN=#{rut_sii}&type=CEDULA&serial=#{serial}"))
			serial_valid = page.css('.setWidthOfSecondColumn').text == 'Vigente'
		end
		OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_PEER)
		unless serial_valid
			code = 403
		end
		message = if code == 200
			'Cedula vigente'
		elsif code == 403
			'Documento inválido'
		elsif code == 404
			'Rut inválido'
		end
		respond_to do |format|
			format.json { render json: [rut: rut_sii, name: name, serial: serial, code: code, message: message] }
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
		id_document_serial = params[:user][:id_document_serial]

		@user = User.new(avatar: uploaded_io.original_filename, first_name: first_name, last_name: last_name, id_number: id_number, email: email, password: password, password_confirmation: password_confirmation, user_type_id: 3, invite_code: invitation_code, id_document_serial: id_document_serial)
		if @user.save
			#3.times do
			#	@user.invite_codes << InviteCode.create()
			#end
			dir = 'uploads/users/' + @user.id.to_s() + '/'
			avatar_path = dir + uploaded_io.original_filename
			@user.avatar = avatar_path
			@user.save
			FileUtils.mkdir_p('public/' + dir) unless File.directory?(dir)
			File.open(Rails.root.join('public', avatar_path), 'wb') do |file|
				file.write(uploaded_io.read)
			end
			redirect_to user_root_url, :notice => "Registrado!"
		else
			render "new"
		end
	end

	def invite
		emails = params[:e]
		document_id = params[:d]
		invitation_type = params[:t]
		users = []
		emails.split(",").each do |email|
			if invitation_type == 'participant'
				user = User.where('"email" = \'' + email + '\'').first
				unless user
					#Pendiente: Implementar validación diferida según endpoint	
					user = User.new(email: email, password: email, password_confirmation: email)
					pending = UserType.find_by name: 'Pendiente'
					user.user_type = pending
					user.save
				end
				user.reload
				document = Document.find(document_id)
				if document
					if Participant.where('"document_id" = ' + document.id.to_s + ' AND "user_id" = ' + user.id.to_s).exists? == false
						invitee = Role.find_by name: 'Invitado'
						participant = Participant.new(document_id: document.id, role: invitee, user_id: user.id, signed: 'f')
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

	def complete_invitee_profile
		user_id = params[:u] #user_id
		user = nil
		if user_id
			user = User.find(user_id)
			@user_email = user.email
		else
			#avatar = params[:avatar]
			first_name = params[:first_name]
			last_name = params[:last_name]
			email = params[:email]
			password = params[:password]
			password_confirmation = params[:password_confirmation]
			id_number = params[:id_number]
			user = User.find_by email: email
			if user
				#user.avatar = avatar
				free = UserType.find_by name: 'Invitado'
				user.user_type = free
				user.first_name = first_name
				user.last_name = last_name
				user.email = email
				user.password = password
				user.id_number = id_number
				user.save
				redirect_to user_root_url
			end
		end
	end

	def complete_invitee_profile_save
#=begin
#=end
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
