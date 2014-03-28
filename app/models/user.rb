class User < ActiveRecord::Base
	has_and_belongs_to_many :documents

	attr_accessor :password
	before_save :encrypt_password

	validates :password,
				presence: true,
				confirmation: true
	validates :email,
				presence: true,
				uniqueness: true
	validates :first_name,
				presence: true
	validates :last_name,
				presence: true
	validates :avatar,
				presence: true

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
