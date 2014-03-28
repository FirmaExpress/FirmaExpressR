class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		#@user = User.new(params[:user])
		uploaded_io = params[:user][:avatar]
		first_name = params[:user][:first_name]
		last_name = params[:user][:last_name]
		email = params[:user][:email]
		password = params[:user][:password]
		password_confirmation = params[:user][:password_confirmation]

		@user = User.new(avatar: uploaded_io.original_filename, first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password_confirmation)
		if @user.save
			dir = 'public/uploads/users/' + @user.id.to_s() + '/'
			FileUtils.mkdir_p(dir) unless File.directory?(dir)
			#@@my_logger ||= Logger.new("#{Rails.root}/log/#{today}/my.log")
			File.open(Rails.root.join('public', 'uploads/users/' + @user.id.to_s() + '/', uploaded_io.original_filename), 'wb') do |file|
				file.write(uploaded_io.read)
			end
			redirect_to root_url, :notice => "Signed up!"
		else
			render "new"
		end
	end
end
