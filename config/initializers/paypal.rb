PayPal::Recurring.configure do |config|
	if Rails.env.production?
		config.sandbox = false
		config.username = 'claudio.guerra_api1.firmaexpress.com'
		config.password = '6L7V8KPWZ78G3Z3G'
		config.signature = 'AiLmO7bn-mivROZZ1IkMcsZQuy0vAhnkNZtAM7fHuanP7GjUgf9Q.JlC'
	else
		config.sandbox = true
		config.username = 'claudio.guerra-facilitator_api1.firmaexpress.com'
		config.password = '4ERXC6ABLTDE4N4V'
		config.signature = 'AHlPGNepMFDOcq11cW7hr-OsduMIAva5dxJyI9IEOAgOuFbDAfckFX9T'
	end
end