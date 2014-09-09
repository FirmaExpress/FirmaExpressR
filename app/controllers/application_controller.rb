class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :first_name, :last_name, :id_number, :email, :password, :password_confirmation, :invite_code, :id_document_serial, :plan_id, :paypal_customer_token, :paypal_payment_token) }
	end

	#helper_method :current_user

	#private

	#def current_user
	#	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	#end

	#helper_method :auth

	#private

	#def check_auth
	#	if user_signed_in?
	#		redirect_to '/login'
	#	else
	#		@invitations_left = current_user.invite_codes.where(available: true)
	#	end
	#end

	def invitations_left
		@invitations_left = current_user.invite_codes.where(available: true) if user_signed_in?
	end

	def invitations
		@invitations ||= current_user.invite_codes if current_user
	end
end
