class ContactsController < ApplicationController
  def index
    @contact_info = StaticBlock.get_block("contacts").text
    @contact = ContactMessage.new flash[:contact]
  end
  
  def create
    contact = ContactMessage.new params[:contact]
    if contact.save
      flash[:notice] = t.contacts.message_sent
    else
      flash[:alert] = t.contacts.message_errors + contact.errors.full_messages*", "
      flash[:contact] = params[:contact]
    end
    redirect_to contacts_path
  end
end
