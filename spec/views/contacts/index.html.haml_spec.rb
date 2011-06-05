require 'spec_helper'

describe "contacts/index.html.haml" do
  before :each do
    @contact = mock_model(ContactMessage).as_new_record.as_null_object
    assign :contact, @contact
    assign :contact_info, "<p class='text'>Greetings!</p>"
    render
  end
  
  it "shows text of @contact_info" do
    rendered.should contain("Greetings!")
  end
  
  it "shows tags in text of @contact_info" do
    rendered.should have_selector("p", :class => "text")
  end
  
  it "renders form for new contact message" do
    rendered.should have_selector("form", :method => "post",
                                  :action => contacts_path) do |form|
      form.should have_selector("input", :type => "text", :name => "contact[name]")
      form.should have_selector("input", :type => "text", :name => "contact[email]")
      form.should have_selector("input", :type => "text", :name => "contact[phone]")
      form.should have_selector("textarea", :name => "contact[message]")
      form.should have_selector("input", :type => "submit")
    end
  end
end