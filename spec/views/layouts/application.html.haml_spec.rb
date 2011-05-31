require 'spec_helper'

describe "layouts/application.html.haml" do
  describe "menu" do
    let(:section1){mock_model(Section, :name=>"Logo", :id => 5).as_null_object}
    let(:section2){mock_model(Section, :name=>"Web", :id => 7).as_null_object}
    before :each do
      assign :sections, [section1,section2]
      render
    end
    
    it "shows menu" do
      rendered.should have_selector("ul.menu")
    end
    
    it "shows sections within menu" do
      rendered.should contain("Logo")
      rendered.should contain("Web")
    end
    
    it "shows links to section within menu" do
      rendered.should have_selector(".menu a", :href => section_path(section1))
      rendered.should have_selector(".menu a", :href => section_path(section2))
    end
  end
end
