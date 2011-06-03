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

  # Layout tested here, because without controller tests are invalid
  describe "in layouts/application.html.haml" do
    render_views
    let(:section1){mock_model(Section, :name=>"Logo", :id => 5).as_null_object}
    let(:section2){mock_model(Section, :name=>"Web", :id => 7).as_null_object}
    before :each do
      Section.stub(:enabled).and_return [section1,section2]
      get :index, :locale => 'en'
    end
      
    describe "menu" do
      it "shows menu" do
        response.should have_selector("ul.menu")
      end
    end
    
    describe "locales_menu" do
      it "shows locales menu" do
        response.should have_selector(".locales_menu")
      end
      
      it "shows links for all supported languages" do
        response.should have_selector("#switch_to_locale_cs")
        response.should have_selector("#switch_to_locale_en")
        response.should have_selector("#switch_to_locale_ru")
      end
    end
  end
end
