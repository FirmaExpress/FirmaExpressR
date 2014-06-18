class Sign < ActiveRecord::Base
	belongs_to :participant
	has_many :used_sign_security_methods
end