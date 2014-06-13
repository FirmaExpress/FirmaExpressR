class SignType < ActiveRecord::Base
	has_many :signs
	has_many :requested_sign_types
end