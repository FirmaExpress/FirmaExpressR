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
	avatar: 'uploads/user.jpg', 
	first_name: 'Claudio', 
	last_name: 'Guerra', 
	id_number: '17026575-0', 
	email: 'claudevandort@gmail.com', 
	password: '1234', 
	password_confirmation: '1234',
	user_type_id: 1 }])