require 'spec_helper'

describe ContactsController do
  describe "GET index" do
    let(:contacts_static_block){mock_model(StaticBlock, :text => "Greetings!")}
    before :each do
      StaticBlock.stub(:get_block).and_return contacts_static_block
    end
    
    it "asks 'contacts' static block" do
      StaticBlock.should_receive(:get_block).with 'contacts'
      get :index, :locale => 'en'
    end
    
    it "assigns text of 'contacts' static block" do
      get :index, :locale => 'en'
      assigns[:contacts].should == "Greetings!"
    end
  end
end
