require 'spec_helper'

describe "admin/projects/index.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @project = mock_model(Project, :id => 1, :name=>"Cherry").as_null_object
    assign :projects, [@project]
  end
  
  it "shows project's name" do
    render
    rendered.should contain("Cherry")
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
  
  it "shows link to show project on frontend"
end