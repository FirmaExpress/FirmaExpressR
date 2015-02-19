class InviteCode < ActiveRecord::Base
	belongs_to :user
	before_create :generate

	def generate
		code = ''
		begin
			code = generate_code
		end while InviteCode.exists?(code: code)
		self.code = code
		self.available = true
	end

	def generate_code
		template   = 'XX99-XX99-99XX-99XX-XXXX-99XX'
		code = ''
		template.each_char do |char|
			case char
			when 'X'
				code += Random.new.rand(65..90).chr
			when '9'
				code += Random.new.rand(0..9).to_s
			when '-'
				code += '-'
			end
		end
		return code
	end
end