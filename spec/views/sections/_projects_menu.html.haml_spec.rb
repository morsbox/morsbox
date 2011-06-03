require 'spec_helper'

describe "sections/_projects_menu.html.haml" do
  let(:project1){mock_model Project, :name => "Project 1"}
  let(:project2){mock_model Project, :name => "Project 2"}
  before :each do
    assign :projects, [project1, project2]
  end
  
  it "shows names of given projects" do
    render
    rendered.should contain("Project 1")
    rendered.should contain("Project 2")
  end
  
  it "shows links to given projects" do
    render
    rendered.should have_selector("a", :href => project_path(project1))
    rendered.should have_selector("a", :href => project_path(project2))
  end
  
  it "selects current project if given" do
    assign :project, project2
    render
    rendered.should have_selector("li.selected") do |selected|
      selected.should contain("Project 2")
    end
  end
end
