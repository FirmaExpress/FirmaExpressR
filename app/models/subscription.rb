class Subscription < ActiveRecord::Base
	belongs_to :plan
	has_many :invoices
end