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
	user_type_id: 1 },{ 
	avatar: nil, 
	first_name: 'Diego', 
	last_name: 'Maturana', 
	id_number: '2-7', 
	email: 'diegomaturanabaeza@gmail.com', 
	password: 'D13g0M4tur4n4', 
	password_confirmation: 'D13g0M4tur4n4',
	user_type_id: 1 }])
check = SignSecurityMethod.new
check.name = 'Verificación simple'
check.save
captcha = SignSecurityMethod.new
captcha.name = 'Captcha'
captcha.save
nombre = SignSecurityMethod.new
nombre.name = 'Nombre'
nombre.save

level_a = SignSecurityLevel.new
level_a.level = 1
level_a.name = 'Nivel 1'
level_a.description = 'Verificación simple'
level_a.sign_security_methods << check
level_a.save

level_b = SignSecurityLevel.new
level_b.level = 2
level_b.name = 'Nivel 1'
level_b.description = 'V. simple y captcha'
level_b.sign_security_methods << check
level_b.sign_security_methods << captcha
level_b.save

level_c = SignSecurityLevel.new
level_c.level = 2
level_c.name = 'Nivel 1'
level_c.description = 'V. simple y nombre'
level_c.sign_security_methods << check
level_c.sign_security_methods << nombre
level_c.save

level_d = SignSecurityLevel.new
level_d.level = 3
level_d.name = 'Nivel 1'
level_d.description = 'V. simple, captcha y nombre'
level_d.sign_security_methods << check
level_d.sign_security_methods << captcha
level_d.sign_security_methods << nombre
level_d.save