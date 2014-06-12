class Sign < ActiveRecord::Base
	belongs_to :participant
	belongs_to :sign_type
end