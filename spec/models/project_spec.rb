require 'spec_helper'

describe Project do
  it "is not valid without russian name" do
    Factory.build(:project, :name_ru => nil).should_not be_valid
  end
end
