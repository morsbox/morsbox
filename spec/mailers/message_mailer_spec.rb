require "spec_helper"
include EmailSpec::Helpers
include EmailSpec::Matchers

describe MessageMailer do
  describe "#contact_message" do
    before :each do
      @contact_message = Factory :contact_message
      @admin = Factory :admin, :email => "admin@domain.com"
      @email = MessageMailer.contact_message @contact_message
    end
    
    it "sends email to all admin's email" do
      @email.should deliver_to(["admin@domain.com"])  
    end
    
    it "contains message attributes" do
      @email.should have_body_text(/#{@contact_message.name}/)
      @email.should have_body_text(/#{@contact_message.email}/)
      @email.should have_body_text(/#{@contact_message.phone}/)
      @email.should have_body_text(/#{@contact_message.message}/)
    end
  end
end
