require 'spec_helper'

describe Admin::IndexHelper do
  describe "link_to_toggle" do
    context "when single model passed" do
      before :each do
        R18n.set(R18n::I18n.new('ru'))
        @category = mock_model Section, :id => 1, :enabled => false
        @result = helper.link_to_toggle(@category)
      end
      
      it "returns link to resource" do
        @result.should.should=~ /\/admin\/sections\/1/
      end
      
      it "returns query string with resource[enabled] negative to actual value" do
         @result.should=~ /section\[enabled\]=true/
      end
      
      it "returns link with put method" do
        @result.should have_selector("a", "data-method" => "put")
      end
    end
    
    context "when array passed" do
      before :each do
        R18n.set(R18n::I18n.new('ru'))
        @project = mock_model Project, :id => 1
        @description = mock_model Description, :id => 10, :enabled => false
        @result = helper.link_to_toggle [@project, @description]
      end
      
      it "returns link to resource" do
        @result.should.should=~ /\/admin\/projects\/1\/descriptions\/10/
      end
      
      it "returns query string with resource[enabled] negative to actual value" do
         @result.should=~ /description\[enabled\]=true/
      end
      
      it "returns link with put method" do
        @result.should have_selector("a", "data-method" => "put")
      end
    end
  end
end
