require 'spec_helper'

describe "pages/contacts.html.haml" do
  before :each do
    assign :contacts, "<p class='text'>Greetings!</p>"
    render
  end
  
  it "shows text of @contacts" do
    rendered.should contain("Greetings!")
  end
  
  it "shows tags in text of @contacts" do
    rendered.should have_selector("p", :class => "text")
  end
end
