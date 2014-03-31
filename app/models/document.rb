class Document < ActiveRecord::Base
	#has_and_belongs_to_many :users
	has_many :participants
	has_many :users, through: :participants
	has_many :roles, through: :participants
end
