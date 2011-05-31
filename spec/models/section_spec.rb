require 'spec_helper'

describe Section do
  describe "scope :enabled" do
    before :each do
      @section = Factory :section
      @disabled_section = Factory :section, :enabled => false
    end
    
    it "returns enabled sections" do
      Section.enabled.should include(@section)
    end
    
    it "doesn't return disabled sections"do
      Section.enabled.should_not include(@disabled_section)
    end
    
    it "returns sections ordered by show_order" do
      @second_section = Factory  :section, :show_order => 1
      Section.enabled.should == [@second_section,@section]
    end
    
    it "returns sections with equal show_order ordered by creation time" do
      @second_section = Factory :section
      Section.enabled.should == [@section,@second_section]
    end
  end
end
