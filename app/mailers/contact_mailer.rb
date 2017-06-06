class CommentMeiler < ActionMailer::Base
 
  def update_info(name, email, body)
    
    mail(from:"san4es113@gmail.com",to: "san4es113@gmail.com"  , subject: 'The message from support')
  end
end