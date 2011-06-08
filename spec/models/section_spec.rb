require 'spec_helper'

describe Section do
  it "is not valid without russian name" do
    Factory.build(:section, :name_ru => nil).should_not be_valid
  end
  
  describe "scope :sorted" do
    before :each do
      @section = Factory :section
    end
    
    it "returns sections ordered by show_order" do
      @second_section = Factory  :section, :show_order => 1
      Section.sorted.should == [@section,@second_section]
    end
    
    it "returns sections with equal show_order ordered by creation time" do
      @second_section = Factory :section, :created_at => Time.now.tomorrow
      Section.sorted.should == [@second_section,@section]
    end
  end
  
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
      Section.enabled.should == [@section,@second_section]
    end
    
    it "returns sections with equal show_order ordered by creation time" do
      @second_section = Factory :section, :created_at => Time.now.tomorrow
      Section.enabled.should == [@second_section,@section]
    end
  end
end
