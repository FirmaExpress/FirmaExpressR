class SubscriptionsController < ApplicationController
	def new
		@plan = Plan.find(params[:plan_id])
		@subscription = Subscription.new
		@subscription.plan = @plan
		if params[:PayerID]
			@subscription.paypal_customer_token = params[:PayerID]
			@subscription.paypal_payment_token = params[:token]
			@subscription.email = @subscription.paypal.checkout_details.email
		end
	end

	def paypal_checkout
		plan = Plan.find(params[:plan_id])
		subscription = plan.subscriptions.build
		redirect_to subscription.paypal.checkout_url(
			return_url: new_subscription_url(plan_id: plan.id),
			cancel_url: root_url)
	end

	def create
		#raise params[:subscription].inspect
		@subscription = Subscription.new(subscription_params)
		if @subscription.save_with_payment
			user = if User.exists? email: @subscription.email
				User.find_by email: @subscription.email
			else
				User.create!(email: @subscription.email, user_type_id: 4, password: '12345678')
			end
			user.subscriber.subscriptions << @subscription
			user.subscriber.save
			#redirect_to @subscription, :notice => "Gracias por subscribirte!"
			redirect_to users_complete_invitee_profile_url(u: user.id)
		else
			render :new
		end
	end

	def show
		@subscription = Subscription.find(params[:id])
	end

	def subscription_params
		params.require(:subscription).permit(:email, :plan_id, :paypal_customer_token, :paypal_payment_token)
	end
end