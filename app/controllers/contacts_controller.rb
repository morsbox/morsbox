class ContactsController < ApplicationController
  def index
    @contact_message = StaticBlock.get_block("contacts").text
  end
  
  def create
  end
end
