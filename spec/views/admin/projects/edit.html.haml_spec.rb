require 'spec_helper'

describe "admin/projects/edit.html.haml" do
  before :each do
    R18n.set(R18n::I18n.new('ru'))
    @section = mock_model(Section, :name=>"Logo", :id=>1).as_null_object
    @project = mock_model(Project, :section_id => 1).as_null_object
    assign :admin_sections, [@section]
    assign :project, @project
    assign :descriptions, []
  end
  
  it "shows link to list of projects" do
    render
    rendered.should have_selector("a", :href => admin_projects_path)
  end
  
  it "renders a multilingual form to update a project" do
    render
    rendered.should have_selector("form", :method => "post",
                                  :action => admin_project_path(@project)) do |form|
      form.should have_selector("input", :type => "hidden", :name => "_method",:value=>"put")
      form.should have_selector("input", :type => "text", :name => "project[name_cs]")
      form.should have_selector("input", :type => "text", :name => "project[name_en]")
      form.should have_selector("input", :type => "text", :name => "project[name_ru]")
      form.should have_selector("input", :type => "checkbox", :name => "project[enabled]")
      form.should have_selector("input", :type => "text", :name => "project[show_order]")
      form.should have_selector("select", :name => "project[section_id]") do |s|
        s.should have_selector("option", :value => "1") do |opt|
          opt.should contain("Logo")
        end
      end
      form.should have_selector("input", :type => "submit", :name => "commit")
      form.should have_selector("input", :type => "submit", :name => "apply")
    end
  end
  
  context "descriptions part" do
    before :each do
      @description = mock_model(Description, :text=>"<h3>Theme</h3>").as_null_object
      @description.stub_chain(:image, :url).and_return '/path/to/img.jpg'
      assign :descriptions, [@description]
    end
    
    context "descriptions index" do
      it "shows description's text with tags" do
        render
        rendered.should have_selector("h3") do |header|
          header.should contain("Theme")
        end
      end
      
      it "shows description's thumbnail" do
        render
        rendered.should have_selector("img[src='/path/to/img.jpg']")
      end
    
      it "shows link to toggle activity" do
        view.should_receive(:link_to_toggle).with [@project, @description]
        render
      end
      
      it "shows link to destroy description" do
        render
        rendered.should have_selector("a", "data-method" => "delete",
                          :href => admin_project_description_path(@project, @description))
        
      end
    end
  end
end