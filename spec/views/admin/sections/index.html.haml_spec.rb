require 'spec_helper'

describe "admin/sections/index.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @section = mock_model(Section, :id => 1, :name=>"web_ru").as_null_object
    assign :sections, [@section]
  end
  
  it "shows section's name" do
    render
    rendered.should contain("web_ru")
  end

  it "shows link to edit section" do
    render
    rendered.should have_selector("a", :href => edit_admin_section_path(@section))
  end
  
  it "shows link to destroy section" do
    render
    rendered.should have_selector("a", "data-method" => "delete",
                                  :href => admin_section_path(@section))
  end
end