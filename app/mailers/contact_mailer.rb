class ContactMailer < ActionMailer::Base
 
  def contact_email(name, email, body)
    
    mail(from:"san4es113@gmail.com",to: "san4es113@gmail.com"  , subject: 'The message from support')
  end
end