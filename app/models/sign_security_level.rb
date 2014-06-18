class SignSecurityLevel < ActiveRecord::Base
	has_many :sign_security_level_methods
	has_many :signs_security_methods, through: :sign_security_level_methods
	has_many :documents
end