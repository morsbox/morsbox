class ContactsController < ApplicationController
  def index
    @contact_info = StaticBlock.get_block("contacts").text
  end
  
  def create
  end
end
