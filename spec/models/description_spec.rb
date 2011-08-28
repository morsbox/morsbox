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
    
    it "returns descriptions ordered" do
      @second_description = Factory :description
      Description.enabled.should == [@second_description,@description]
    end
  end
end
