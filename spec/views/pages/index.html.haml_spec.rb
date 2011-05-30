require 'spec_helper'

describe "pages/index.html.haml" do
  before :each do
    assign :home, "<p class='text'>Greetings!</p>"
    render
  end
  
  it "shows text of @home" do
    rendered.should contain("Greetings!")
  end
  
  it "shows tags in text of @home" do
    rendered.should have_selector("p", :class => "text")
  end
end
