class Subscription < ActiveRecord::Base
	belongs_to :plan
	belongs_to :subscriber
	has_many :invoices
	attr_accessor :paypal_payment_token, :email

	def save_with_payment
		if valid? and payment_provided?
			save_with_paypal_payment
		end
	end

	def save_with_paypal_payment
		response = paypal.make_recurring
		self.paypal_recurring_profile_token = response.profile_id
		save!
	end

	def paypal
		PaypalPayment.new(self)
	end

	def payment_provided?
		paypal_payment_token.present?
	end
end