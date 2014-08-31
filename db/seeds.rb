Role.all.each(&:destroy)
UserType.all.each(&:destroy)
User.all.each(&:destroy)
Participant.all.each(&:destroy)
Document.all.each(&:destroy)
SignSecurityLevel.all.each(&:destroy)
SignSecurityMethod.all.each(&:destroy)
SignSecurityLevelMethod.all.each(&:destroy)
UsedSignSecurityMethod.all.each(&:destroy)
Sign.all.each(&:destroy)
OrganizationUser.all.each(&:destroy)
Organization.all.each(&:destroy)
Subscriber.all.each(&:destroy)
Subscription.all.each(&:destroy)
Plan.all.each(&:destroy)
Invoice.all.each(&:destroy)

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

Plan.create name: 'Gratis', documents: 10, templates: false, statistics: false, admin_panel: false, api: false, price: 0
Plan.create name: 'Persona', documents: 300, templates: true, statistics: true, admin_panel: false, api: false, price: 3000
Plan.create name: 'Small Bussines', documents: 1500, templates: true, statistics: true, admin_panel: true, api: false, price: 12500
Plan.create name: 'IT Small Bussines', documents: 1500, templates: true, statistics: true, admin_panel: true, api: true, price: 22500
Plan.create name: 'Corporate', documents: 4500, templates: true, statistics: true, admin_panel: true, api: false, price: 30000
Plan.create name: 'IT Corporate', documents: 4500, templates: true, statistics: true, admin_panel: true, api: true, price: 40000

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