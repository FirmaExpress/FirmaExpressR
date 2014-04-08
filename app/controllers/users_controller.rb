class UsersController < ApplicationController
	def new
		@user = User.new
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
		if @user.save
			dir = 'uploads/users/' + @user.id.to_s() + '/'
			avatar_path = dir + uploaded_io.original_filename
			@user.avatar = avatar_path
			@user.save
			FileUtils.mkdir_p('public/' + dir) unless File.directory?(dir)
			#@@my_logger ||= Logger.new("#{Rails.root}/log/#{today}/my.log")
			File.open(Rails.root.join('public', avatar_path), 'wb') do |file|
				file.write(uploaded_io.read)
			end
			redirect_to root_url, :notice => "Signed up!"
		else
			render "new"
		end
	end

	def invite
		
	end
end
