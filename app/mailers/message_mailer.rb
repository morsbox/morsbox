# encoding: utf-8
class MessageMailer < ActionMailer::Base
  default :from => "no-reply@morsbox.ru"
  
  def contact_message message
    @message = message
    to = Admin.all.map{ |a| a.email }
    mail :to => to, :subject => "Новое сообщение на сайте morsbox.ru"
  end
end
