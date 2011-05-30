require 'spec_helper'

describe StaticBlock do
  before :each do
    @static_block = Factory :static_block, :name => "home"
  end
  it "is not valid without name" do
    @static_block.name = nil
    @static_block.should_not be_valid
  end
  
  it "have unique name" do
    @other_static_block = Factory.build :static_block, :name => "home"
    @other_static_block.should_not be_valid
    # test of the test :)
    @other_static_block.name = "contacts"
    @other_static_block.should be_valid
  end
end
