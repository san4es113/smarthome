class ContactMailer < ActionMailer::Base
  default to: 'san4es113@gmail.com'
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = "Розпізнано нову особу , щоб переглянути відвідайте сайт розумного дому"
    mail(from: email, subject: 'Contact Form Message')
  end
end