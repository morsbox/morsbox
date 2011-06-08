require 'spec_helper'

describe "admin/sections/edit.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @section = mock_model(Section, :id => 1, :name_ru=>"Web").as_null_object
    assign :section, @section
    render
  end
  
  it "shows link to list of sections" do
    rendered.should have_selector("a", :href => admin_sections_path)
  end
  
  it "renders a multilingual form to update a section" do
    rendered.should have_selector("form", :method => "post",
                                :action => admin_section_path(@section)) do |form|
      form.should have_selector("input", :type => "hidden", :name => "_method",:value=>"put")
      form.should have_selector("input", :type => "text", :name => "section[name_cs]")
      form.should have_selector("input", :type => "text", :name => "section[name_en]")
      form.should have_selector("input", :type => "text", :name => "section[name_ru]")
      form.should have_selector("input", :type => "checkbox", :name => "section[enabled]")
      form.should have_selector("input", :type => "text", :name => "section[show_order]")
      form.should have_selector("input", :type => "submit", :name => "commit")
      form.should have_selector("input", :type => "submit", :name => "apply")
    end
  end
end