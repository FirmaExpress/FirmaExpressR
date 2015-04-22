filename = 'original.pdf'
pdf = Prawn::Document.new(template: filename)
users = 1

pdf.go_to_page(pdf.page_count)
users.times.each do |i|
	extra = if users - i == 1 and users % 2 != 0
		150
	else
		0
	end
	pdf.bounding_box([pdf.bounds.left + 50 +(210*i) + extra, pdf.bounds.bottom + 225], width: 200, margin: 20) {
		pdf.image open('public/' + User.find(1).sign_image.url), height: 50, margin: 20, position: :center
		pdf.stroke do
			pdf.horizontal_rule
		end
		pdf.text " "
		pdf.text "Claudio Nicolás Guerra Vera", align: :center
		pdf.text "17026575-0", align: :center
	}
end
pdf.bounding_box([pdf.bounds.left + 50 + 110 , pdf.bounds.bottom + 125], width: 100, margin: 20) {
	pdf.image open("app/assets/images/timbredocumentofirmado.png"), height: 100, position: :center
}
pdf.bounding_box([pdf.bounds.left + 50 + 220 , pdf.bounds.bottom + 125], width: 100, margin: 20) {
	pdf.image open("http://chart.apis.google.com/chart?chs=200x200&cht=qr&chl=http://webapp.dev/check_document/1&choe=ISO-8859-1"), height: 100, position: :center	
}
pdf.bounding_box([pdf.bounds.left + 50 + 330 , pdf.bounds.bottom + 75], width: 100, margin: 20) {
	pdf.text "Sellado: asdasf", align: :center
}
pdf.render_file 'output.pdf'

=begin
Prawn::Document.generate("output.pdf", :skip_page_creation => true) do
  start_new_page(:template => filename)
  text "First page"
  start_new_page(:template => filename)
  text "Second page"
end


pdf.image open('public/' + User.find(1).sign_image.url), height: 100, margin: 20, position: :center
pdf.text "Claudio Nicolás Guerra Vera", align: :center
pdf.text "17026575-0", align: :center
=end