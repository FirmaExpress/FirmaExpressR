class UsedSignSecurityMethod < ActiveRecord::Base
	belongs_to :sign
	belongs_to :sign_security_method
end