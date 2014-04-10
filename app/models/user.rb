class IdNumberValidator < ActiveModel::Validator
  def validate(record)
    rut, dv = record.id_number.split('-')
	rut = rut.delete "."
	rut_reverse = rut.reverse
	multiplier = 2
	real_dv = 0
	for digit in rut_reverse.each_char
		if multiplier > 7
			multiplier = 2
		end
		real_dv += digit.to_i * multiplier
		multiplier += 1
	end
	real_dv = 11 - real_dv % 11
	if real_dv == 10
		real_dv = 'k'
	end
	if real_dv == 11
		real_dv = 0
	end
	if real_dv.to_s != dv
		record.errors[:base] << "RUT inválido"
	end
  end
end

class User < ActiveRecord::Base
	include ActiveModel::Validations
	has_many :participants
	has_many :documents, through: :participants
	has_many :roles, through: :participants
	belongs_to :user_type

	attr_accessor :password
	before_save :encrypt_password

	validates :password,
				presence: true,
				confirmation: true
	validates :email,
				presence: true,
				uniqueness: true,
				format: { with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/, message: "Formato de correo no es válido" }
	validates :first_name,
				presence: true,
				unless: Proc.new { |a| a.id_number.blank? }
	validates :last_name,
				presence: true,
				unless: Proc.new { |a| a.id_number.blank? }
	validates :avatar,
				presence: true
	validates :id_number,
				presence: true,
				uniqueness: true,
				unless: Proc.new { |a| a.id_number.blank? }
	validates_with IdNumberValidator,
				unless: Proc.new { |a| a.id_number.blank? }

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
