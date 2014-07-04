Role.create([{ name: 'Dueño' }, { name: 'Invitado' }])

admin = UserType.create name: 'Admin'
user = UserType.create name: 'Usuario'
free = UserType.create name: 'Invitado'
pending = UserType.create name: 'Pendiente'

User.create([
	{ avatar: nil, first_name: 'Claudio', last_name: 'Guerra', id_number: '17026575-0', email: 'claudevandort@gmail.com', password: '12345678', password_confirmation: '12345678',user_type: admin },
	{ avatar: nil, first_name: 'Patricio', last_name: 'Jara', id_number: '17121986-8', email: 'patricioalfredo18@gmail.com', password: '12345678', password_confirmation: '12345678',user_type: admin },
	{ avatar: nil, first_name: 'Daniel', last_name: 'Vera', id_number: '10974805-6', email: 'danielveram@gmail.com', password: 'guitarra', password_confirmation: 'guitarra',user_type: admin },
	{ avatar: nil, first_name: 'Diego', last_name: 'Maturana', id_number: '2-7', email: 'diegomaturanabaeza@gmail.com', password: 'D13g0M4tur4n4', password_confirmation: 'D13g0M4tur4n4',user_type: admin },
	{ avatar: nil, first_name: 'Francisco', last_name: 'Masjuan', id_number: '1-9', email: 'fmasjuan@co-munity.co', password: 'Fr4nc1sc0', password_confirmation: 'Fr4nc1sc0',user_type: admin }])

check = SignSecurityMethod.create name: 'Verificación simple'
captcha = SignSecurityMethod.create name: 'Captcha'
nombre = SignSecurityMethod.create name: 'Nombre'

SignSecurityLevel.create level: 1, name: 'Nivel 1', description: 'Verificación simple', sign_security_methods: [check]
#SignSecurityLevel.create level: 2, name: 'Nivel 2', description: 'V. simple y captcha', sign_security_methods: [check, captcha]
SignSecurityLevel.create level: 2, name: 'Nivel 2', description: 'V. simple y nombre', sign_security_methods: [check, nombre]
#SignSecurityLevel.create level: 3, name: 'Nivel 3', description: 'V. simple, captcha y nombre', sign_security_methods: [check, captcha, nombre]