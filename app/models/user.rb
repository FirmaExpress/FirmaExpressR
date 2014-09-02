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

class IdDocumentSerialValidator < ActiveModel::Validator
	def validate(record)
		OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_NONE)
		page = Nokogiri::HTML(open("https://portal.sidiv.registrocivil.cl/usuarios-portal/pages/DocumentRequestStatus.xhtml?RUN=#{record.id_number}&type=CEDULA&serial=#{record.id_document_serial}"))
		OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_PEER)
		unless page.css('.setWidthOfSecondColumn').text == 'Vigente'
			#record.errors[:base] << "Cedula inválida, param: #{record.id_document_serial}, result: #{page.css('.setWidthOfSecondColumn').text}"
			record.errors[:base] << 'Cedula inválida'
		end
	end
end

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable
	include ActiveModel::Validations
	has_many :participants
	has_many :documents, through: :participants
	has_many :roles, through: :participants
	belongs_to :subscriber
	has_many :invite_codes
	belongs_to :user_type

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "uploads/user.jpg"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	#attr_accessor :password, :password_confirmation, :current_password
	attr_accessor :invite_code
	attr_accessor :id_document_serial
	before_validation :set_user_id
	attr_accessor :terms

	validates :password,
				presence: true,
				confirmation: true, 
				on: :create

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
	#validates :avatar,
	#			presence: true
	validates :id_number,
				presence: true,
				uniqueness: true,
				unless: Proc.new { |a| a.id_number.blank? }
	validates_with IdNumberValidator,
				unless: Proc.new { |a| a.id_number.blank? }
	validates_with IdDocumentSerialValidator,
				unless: Proc.new { |a| a.id_number.blank? }
	validates_acceptance_of :terms

=begin
	def generate_codes
		unless self.invite_codes
			3.times do
				self.invite_codes << InviteCode.create()
			end
		end
	end
=end

	def set_user_id
		self.user_type_id = 2 if self.user_type_id.blank?
		
		rut, dv = id_number.split('-')
		rut = rut.delete "."
		sii_page = Nokogiri::HTML(open("https://zeus.sii.cl/cvc_cgi/stc/getstc?RUT=#{rut}&DV=#{dv}&PRG=STC&OPC=NOR"))
		begin
			full_name = sii_page.css('html body center')[1].css('table')[0].css('tr')[0].css('td')[1].css('font').text.strip.titleize
			self.first_name = full_name.match(/^([^ ]*\ [^ ]*)\ (.*)$/)[1]
			self.last_name = full_name.match(/^([^ ]*\ [^ ]*)\ (.*)$/)[2]
		rescue Exception => e
			self.first_name = ''
			self.last_name = ''
		end
		self.subscriber = Subscriber.create
		self.subscriber.plans << Plan.first
	end

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
end
