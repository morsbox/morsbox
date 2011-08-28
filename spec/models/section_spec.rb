require 'spec_helper'

describe Section do
  it "is not valid without russian name" do
    Factory.build(:section, :name_ru => nil).should_not be_valid
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
    
    it "returns sections ordered" do
      @second_section = Factory  :section
      Section.enabled.should == [@second_section,@section]
    end
  end
  
  describe "#projects" do
    it "nullify project's section_id when destroy" do
      @section = Factory :section
      @project = Factory :project
      @section.projects << @project
      @section.destroy
      @project.reload.section_id.should be_nil
    end
  end
end
