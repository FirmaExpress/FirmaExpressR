class Document < ActiveRecord::Base
	#has_and_belongs_to_many :users
	has_many :participants
	has_many :users, through: :participants
	has_many :roles, through: :participants

	def agreed
		return !self.agreed_at.blank?
	end

	def to_sign
		return Document.joins(:participants, :users, :roles).select('"documents".*, "participants".*, "users".*, "roles".name as role').where('"documents"."id" = ' + self.id.to_s + ' AND "participants".signed = \'f\'').count
	end
end
