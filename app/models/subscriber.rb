class Subscriber < ActiveRecord::Base
	has_one :user
	has_many :subscriptions
	has_many :plans, through: :subscriptions
	has_many :invoices, through: :subscriptions
end