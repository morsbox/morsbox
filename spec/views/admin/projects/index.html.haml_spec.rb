require 'spec_helper'

describe "admin/projects/index.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @section = mock_model(Section, :name=>"Logo", :id=>1).as_null_object
    @project = mock_model(Project, :name=>"Cherry").as_null_object
    @project.stub(:section).and_return @section
    assign :admin_sections, [@section]
    assign :projects, [@project]
  end
  
  it "shows filter for section" do
    render
    rendered.should have_selector("form", :method => "get",
                                  :action => admin_projects_path) do |form|
      form.should have_selector("select", :name => "section_id") do |s|
        s.should have_selector("option", :value => "1") do |opt|
          opt.should contain("Logo")
        end
      end
    end
  end
  
  it "shows project's name" do
    render
    rendered.should contain("Cherry")
  end
  
  it "shows project's section" do
    render
    rendered.should have_selector("table") do |table|
      table.should contain("Logo")
    end
  end

  it "shows link to edit project" do
    render
    rendered.should have_selector("a", :href => edit_admin_project_path(@project))
  end
  
  it "shows link to toggle activity" do
    view.should_receive(:link_to_toggle).with @project
    render
  end
  
  it "shows form for editing show_order" do
    render
    rendered.should have_selector("form", :method => "post",
                                  :action => admin_project_path(@project)) do |form|
      form.should have_selector("input", :type => "hidden", :name => "_method",:value=>"put")
      form.should have_selector("input", :type => "text", :name => "project[show_order]")
    end
  end
  
  it "shows link to destroy project" do
    render
    rendered.should have_selector("a", "data-method" => "delete",
                                  :href => admin_project_path(@project))
    
  end
  
  it "shows link to show project on frontend" do
    render
    rendered.should have_selector("a", :href => project_path(@project))
  end
end