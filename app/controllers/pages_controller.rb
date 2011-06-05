class PagesController < ApplicationController
  def index
    @home = StaticBlock.get_block("home").text
  end
end
