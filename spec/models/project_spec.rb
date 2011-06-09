require 'spec_helper'

describe Project do
  it "is not valid without russian name" do
    Factory.build(:project, :name_ru => nil).should_not be_valid
  end
  
  describe "scope :sorted" do
    before :each do
      @project = Factory :project
    end

    it "returns projects ordered by show_order" do
      @second_project = Factory :project, :show_order => 1
      Project.sorted.should == [@project,@second_project]
    end
    
    it "returns projects with equal show_order ordered by creation time" do
      @second_project = Factory :project, :created_at => Time.now.tomorrow
      Project.sorted.should == [@second_project,@project]
    end
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
    
    it "returns projects ordered by show_order" do
      @second_project = Factory :project, :show_order => 1
      Project.enabled.should == [@project,@second_project]
    end
    
    it "returns projects with equal show_order ordered by creation time" do
      @second_project = Factory :project, :created_at => Time.now.tomorrow
      Project.enabled.should == [@second_project,@project]
    end
  end
end
