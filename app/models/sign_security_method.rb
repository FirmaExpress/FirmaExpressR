class SignSecurityMethod < ActiveRecord::Base
	has_many :used_sign_security_methods
	has_many :signs, through: :used_sign_security_methods
	has_many :sign_security_level_methods
	has_many :sign_security_levels, through: :sign_security_level_methods
end