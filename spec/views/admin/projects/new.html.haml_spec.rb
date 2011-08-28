require 'spec_helper'

describe "admin/projects/new.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @section = mock_model(Section, :name=>"Logo", :id=>1).as_null_object
    @project = mock_model(Project).as_new_record.as_null_object
    assign :admin_sections, [@section]
    assign :project, @project
    render
  end

  it "shows link to list of projects" do
    rendered.should have_selector("a", :href => admin_projects_path)
  end

  it "renders form for new project" do
    rendered.should have_selector("form", :method => "post",
                                  :action => admin_projects_path) do |form|
      form.should have_selector("input", :type => "text", :name => "project[name_cs]")
      form.should have_selector("input", :type => "text", :name => "project[name_en]")
      form.should have_selector("input", :type => "text", :name => "project[name_ru]")
      form.should have_selector("input", :type => "checkbox", :name => "project[enabled]")
      form.should have_selector("select", :name => "project[section_id]") do |s|
        s.should have_selector("option", :value => "1") do |opt|
          opt.should contain("Logo")
        end
      end
      form.should have_selector("input", :type => "submit", :name => "commit")
      form.should have_selector("input", :type => "submit", :name => "apply")
    end
  end
end