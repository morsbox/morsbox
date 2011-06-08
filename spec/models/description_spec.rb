require 'spec_helper'

describe Description do
  describe "scope :enabled" do
    before :each do
      @description = Factory :description
      @disabled_description = Factory :description, :enabled => false
    end
    
    it "returns enabled descriptions" do
      Description.enabled.should include(@description)
    end
    
    it "doesn't return disabled descriptions"do
      Description.enabled.should_not include(@disabled_description)
    end
    
    it "returns descriptions ordered by show_order" do
      @second_description = Factory :description, :show_order => -1
      Description.enabled.should == [@second_description,@description]
    end
    
    it "returns descriptions with equal show_order ordered by creation time" do
      @second_description = Factory :description
      Description.enabled.should == [@description,@second_description]
    end
  end
end
