require 'spec_helper'

describe Project do
  it "is not valid without russian name" do
    Factory.build(:project, :name_ru => nil).should_not be_valid
  end

  describe "scope :enabled" do
    before :each do
      @project = Factory :project
      @disabled_project = Factory :project, :enabled => false
    end
    
    it "returns enabled projects" do
      Project.enabled.should include(@project)
    end
    
    it "doesn't return disabled projects"do
      Project.enabled.should_not include(@disabled_project)
    end
    
    it "returns projects ordered" do
      @second_project = Factory :project
      Project.enabled.should == [@second_project,@project]
    end
  end
  
  describe "#descriptions" do
    it "also destroy descriptions when destroy" do
      @project = Factory :project
      @description = Factory :description
      @project.descriptions << @description
      lambda{ @project.destroy }.should change(Description, :count)
    end
  end
end
