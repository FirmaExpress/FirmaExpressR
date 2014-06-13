class RequestedSignType < ActiveRecord::Base
	belongs_to :sign_type
	belongs_to :document
end