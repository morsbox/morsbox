require 'spec_helper'

describe ContactMessage do
  it "is not valid without name" do
    Factory.build(:contact_message, :name => nil).should_not be_valid
  end
  
  it "is not valid without message" do
    Factory.build(:contact_message, :message => nil).should_not be_valid
  end
  
  it "is not valid without email" do
    Factory.build(:contact_message, :email => nil).should_not be_valid
  end
  
  it "has valid email" do
    Factory.build(:contact_message, :email => "not_email").should_not be_valid
  end
end
