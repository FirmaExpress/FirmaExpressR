class Sign < ActiveRecord::Base
	belongs_to :participant
	has_many :used_sign_security_methods
	has_many :sign_security_methods, through: :used_sign_security_methods
end