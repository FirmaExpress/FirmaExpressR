class SessionsController < ApplicationController
  def new
  	redirect_to root_url
  end
	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			redirect_to user_root_url, :notice => "Logged in!"
		else
			flash.now.alert = "Su email o password es Incorrecto"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
end
