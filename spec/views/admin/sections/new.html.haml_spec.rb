require 'spec_helper'

describe "admin/sections/new.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @section = mock_model(Section).as_new_record.as_null_object
    assign :section, @section
    render
  end

  it "shows link to list of sections" do
    rendered.should have_selector("a", :href => admin_sections_path)
  end

  it "renders form for new section" do
    rendered.should have_selector("form", :method => "post",
                                  :action => admin_sections_path) do |form|
      form.should have_selector("input", :type => "text", :name => "section[name_cs]")
      form.should have_selector("input", :type => "text", :name => "section[name_en]")
      form.should have_selector("input", :type => "text", :name => "section[name_ru]")
      form.should have_selector("input", :type => "checkbox", :name => "section[enabled]")
      form.should have_selector("input", :type => "submit", :name => "commit")
      form.should have_selector("input", :type => "submit", :name => "apply")
    end
  end
end