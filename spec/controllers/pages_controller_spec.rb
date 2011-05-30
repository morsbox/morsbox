require 'spec_helper'

describe PagesController do
  describe "GET index" do
    let(:home_static_block){mock_model(StaticBlock, :text => "Greetings!")}
    before :each do
      StaticBlock.stub(:get_block).and_return home_static_block
    end
    
    it "asks 'home' static block" do
      StaticBlock.should_receive(:get_block).with 'home'
      get :index, :locale => 'en'
    end
    
    it "assigns text of 'home' static block" do
      get :index, :locale => 'en'
      assigns[:home].should == "Greetings!"
    end
  end

end
