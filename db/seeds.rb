# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create([{ name: 'Dueño' }, { name: 'Pendiente' }, { name: 'Invitado' }])
User.create(avatar: '1', first_name: '1', last_name: '1', email: '1', password: '1', password_confirmation: '1')
