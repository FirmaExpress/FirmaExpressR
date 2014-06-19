class DocumentValidator < ActiveModel::Validator
	def validate(record)
		unless record.file.content_type == "application/pdf"
			record.errors[:base] << "El documento debe estar en formato PDF"
		end
	end
end

class Document < ActiveRecord::Base
	include ActiveModel::Validations
	has_many :participants
	has_many :users, through: :participants
	has_many :roles, through: :participants
	has_many :signs, through: :participants
	belongs_to :sign_security_level

	validates :name, presence: true
	validates :path, presence: true
	validates_with DocumentValidator, on: :create

	attr_accessor :file
	attr_accessor :dir
	attr_accessor :user_id

	before_validation :set_document_values, on: :create
	after_validation :save_file, on: :create

	def set_document_values
		if file
			self.name = self.file.original_filename
		end
		if user_id
			self.dir = 'uploads/users/' + user_id.to_s() + '/documents/'
			self.path = dir + name
		end
	end

	def save_file
		FileUtils.mkdir_p('public/' + dir) unless File.directory?(dir)
		File.open(Rails.root.join('public', self.dir, self.name), 'wb') do |file|
			file.write(self.file.read)
		end
	end

	def agreed
		return !self.agreed_at.blank?
	end

	def to_sign
		return Document.joins(:participants, :users, :roles).select('"documents".*, "participants".*, "users".*, "roles".name as role').where('"documents"."id" = ' + self.id.to_s + ' AND "participants".signed = \'f\'').count
	end
end
