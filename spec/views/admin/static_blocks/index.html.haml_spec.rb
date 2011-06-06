require 'spec_helper'

describe "admin/static_blocks/index.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @static_block = mock_model(StaticBlock, :id => 1, :name=>"home").as_null_object
    assign :static_blocks, [@static_block]
  end
  
  it "shows static block's name" do
    render
    rendered.should contain("home")
  end

  it "shows link to edit static block" do
    render
    rendered.should have_selector("a", :href => edit_admin_static_block_path(@static_block))
  end
  
  it "shows link to destroy static block" do
    render
    rendered.should have_selector("a", "data-method" => "delete",
                                  :href => admin_static_block_path(@static_block))
  end
end