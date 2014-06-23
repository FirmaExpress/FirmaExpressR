# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create([{ name: 'Dueño' }, { name: 'Pendiente' }, { name: 'Invitado' }])
UserType.create([{ name: 'Master' }, { name: 'Invitado' }, { name: 'Free' }])
User.create([{ 
	avatar: nil, 
	first_name: 'Claudio', 
	last_name: 'Guerra', 
	id_number: '17026575-0', 
	email: 'claudevandort@gmail.com', 
	password: '12345678', 
	password_confirmation: '12345678',
	user_type_id: 1 },{ 
	avatar: nil, 
	first_name: 'Francisco', 
	last_name: 'Masjuan', 
	id_number: '1-9', 
	email: 'fmasjuan@co-munity.co', 
	password: 'Fr4nc1sc0', 
	password_confirmation: 'Fr4nc1sc0',
	user_type_id: 1 },{ 
	avatar: nil, 
	first_name: 'Patricio', 
	last_name: 'Jara', 
	id_number: '17121986-8', 
	email: 'patricioalfredo18@gmail.com', 
	password: '12345678', 
	password_confirmation: '12345678',
	user_type_id: 1 }])
check = SignSecurityMethod.new
check.name = 'Check'
check.save
captcha = SignSecurityMethod.new
captcha.name = 'Captcha'
captcha.save
nombre = SignSecurityMethod.new
nombre.name = 'Nombre'
nombre.save

level_a = SignSecurityLevel.new
level_a.level = 1
level_a.sign_security_methods << check
level_a.save
level_b = SignSecurityLevel.new
level_b.level = 2
level_b.sign_security_methods << check
level_b.sign_security_methods << captcha
level_b.save
level_b = SignSecurityLevel.new
level_b.level = 2
level_b.sign_security_methods << check
level_b.sign_security_methods << nombre
level_b.save
level_c = SignSecurityLevel.new
level_c.level = 3
level_c.sign_security_methods << check
level_c.sign_security_methods << captcha
level_c.sign_security_methods << nombre
level_c.save