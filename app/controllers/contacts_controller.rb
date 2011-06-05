class ContactsController < ApplicationController
  def index
    @contacts = StaticBlock.get_block("contacts").text
  end
  
  def create
  end
end
