Role.destroy_all; Role.reset_pk_sequence
UserType.destroy_all; UserType.reset_pk_sequence
User.destroy_all; User.reset_pk_sequence
Participant.destroy_all; Participant.reset_pk_sequence
Document.destroy_all; Document.reset_pk_sequence
SignSecurityLevel.destroy_all; SignSecurityLevel.reset_pk_sequence
SignSecurityMethod.destroy_all; SignSecurityMethod.reset_pk_sequence
SignSecurityLevelMethod.destroy_all; SignSecurityLevelMethod.reset_pk_sequence
UsedSignSecurityMethod.destroy_all; UsedSignSecurityMethod.reset_pk_sequence
Sign.destroy_all; Sign.reset_pk_sequence
OrganizationUser.destroy_all; OrganizationUser.reset_pk_sequence
Organization.destroy_all; Organization.reset_pk_sequence
Subscriber.destroy_all; Subscriber.reset_pk_sequence
Subscription.destroy_all; Subscription.reset_pk_sequence
Plan.destroy_all; Plan.reset_pk_sequence
Invoice.destroy_all; Invoice.reset_pk_sequence

Role.create([{ name: 'Dueño' }, { name: 'Invitado' }])

admin = UserType.create name: 'Admin'
user = UserType.create name: 'Usuario'
free = UserType.create name: 'Invitado'
pending = UserType.create name: 'Pendiente'

check = SignSecurityMethod.create name: 'Verificación simple'
captcha = SignSecurityMethod.create name: 'Captcha'
nombre = SignSecurityMethod.create name: 'Nombre'

SignSecurityLevel.create level: 1, name: 'Nivel 1', description: 'Verificación simple', sign_security_methods: [check]
SignSecurityLevel.create level: 2, name: 'Nivel 2', description: 'V. simple y nombre', sign_security_methods: [check, nombre]

Plan.create name: 'Gratis', documents: 10, templates: false, statistics: false, admin_panel: false, api: false, price: 0, price_usd: 0
Plan.create name: 'Persona', documents: 300, templates: true, statistics: true, admin_panel: false, api: false, price: 3000, price_usd: 6
Plan.create name: 'Small Bussines', documents: 1500, templates: true, statistics: true, admin_panel: true, api: false, price: 12500, price_usd: 25
Plan.create name: 'IT Small Bussines', documents: 1500, templates: true, statistics: true, admin_panel: true, api: true, price: 22500, price_usd: 45
Plan.create name: 'Corporate', documents: 4500, templates: true, statistics: true, admin_panel: true, api: false, price: 30000, price_usd: 60
Plan.create name: 'IT Corporate', documents: 4500, templates: true, statistics: true, admin_panel: true, api: true, price: 40000, price_usd: 80

#claudio = User.create id_number: '17026575-0', id_document_serial: '100692111', email: 'claudevandort@gmail.com', password: '12345678', user_type: admin
#claudio.subscriber = Subscriber.create
#claudio.subscriber.plans << Plan.first
#claudio.save
#user = User.first
#user.subscriber.plans.last

#User.create([
#	{ avatar: nil, first_name: 'Daniel', last_name: 'Vera', id_number: '10974805-6', email: 'danielveram@gmail.com', password: 'guitarra', password_confirmation: 'guitarra',user_type: admin },
#	{ avatar: nil, first_name: 'Diego', last_name: 'Maturana', id_number: '2-7', email: 'diegomaturanabaeza@gmail.com', password: 'D13g0M4tur4n4', password_confirmation: 'D13g0M4tur4n4',user_type: admin },
#	{ avatar: nil, first_name: 'Francisco', last_name: 'Masjuan', id_number: '1-9', email: 'fmasjuan@co-munity.co', password: 'Fr4nc1sc0', password_confirmation: 'Fr4nc1sc0',user_type: admin }])