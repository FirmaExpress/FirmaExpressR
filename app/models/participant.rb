class Participant < ActiveRecord::Base
	belongs_to :user
	belongs_to :document
	belongs_to :role
end
