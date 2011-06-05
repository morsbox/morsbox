class PagesController < ApplicationController
  def index
    @home = StaticBlock.get_block("home").text
  end
  
  def contacts
    @contacts = StaticBlock.get_block("contacts").text
  end
end
