Role.create([{ name: 'Dueño' }, { name: 'Invitado' }])

admin = UserType.create name: 'Admin'
user = UserType.create name: 'Usuario'
free = UserType.create name: 'Invitado'
pending = UserType.create name: 'Pendiente'

User.create([
	{ avatar: nil, first_name: 'Daniel', last_name: 'Vera', id_number: '10974805-6', email: 'danielveram@gmail.com', password: 'guitarra', password_confirmation: 'guitarra',user_type: admin },
	{ avatar: nil, first_name: 'Diego', last_name: 'Maturana', id_number: '2-7', email: 'diegomaturanabaeza@gmail.com', password: 'D13g0M4tur4n4', password_confirmation: 'D13g0M4tur4n4',user_type: admin },
	{ avatar: nil, first_name: 'Francisco', last_name: 'Masjuan', id_number: '1-9', email: 'fmasjuan@co-munity.co', password: 'Fr4nc1sc0', password_confirmation: 'Fr4nc1sc0',user_type: admin }])

check = SignSecurityMethod.create name: 'Verificación simple'
captcha = SignSecurityMethod.create name: 'Captcha'
nombre = SignSecurityMethod.create name: 'Nombre'

SignSecurityLevel.create level: 1, name: 'Nivel 1', description: 'Verificación simple', sign_security_methods: [check]
SignSecurityLevel.create level: 2, name: 'Nivel 2', description: 'V. simple y nombre', sign_security_methods: [check, nombre]

Plan.create name: 'Gratis', documents: 10, templates: false, statistics: false, admin_panel: false, api: false, price: 0
Plan.create name: 'Persona', documents: 300, templates: true, statistics: true, admin_panel: false, api: false, price: 3000
Plan.create name: 'Small Bussines', documents: 1500, templates: true, statistics: true, admin_panel: true, api: false, price: 12500
Plan.create name: 'Corporate', documents: 4500, templates: true, statistics: true, admin_panel: true, api: true, price: 30000