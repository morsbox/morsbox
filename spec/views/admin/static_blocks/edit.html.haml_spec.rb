require 'spec_helper'

describe "admin/static_blocks/edit.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @static_block = mock_model(StaticBlock, :id => 1, :name=>"home").as_null_object
    assign :static_block, @static_block
    render
  end
  
  it "shows link to list of static blocks" do
    rendered.should have_selector("a", :href => admin_static_blocks_path)
  end
  
  it "renders a multilingual form to update a static blocks" do
    rendered.should have_selector("form", :method => "post",
                                :action => admin_static_block_path(@static_block)) do |form|
      form.should have_selector("input", :type => "text", :name => "static_block[name]")
      form.should have_selector("textarea", :name => "static_block[text_cs]")
      form.should have_selector("textarea", :name => "static_block[text_en]")
      form.should have_selector("textarea", :name => "static_block[text_ru]")
      form.should have_selector("input", :type => "submit", :name => "commit")
      form.should have_selector("input", :type => "submit", :name => "apply")
    end
  end
end