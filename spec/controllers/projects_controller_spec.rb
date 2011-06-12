require 'spec_helper'

describe ProjectsController do
  describe "GET show" do
    let(:section2){mock_model Section, :name => "Section 2", :enabled => true}
    let(:project1){mock_model Project, :name => "Project 1"}
    let(:project2){mock_model Project, :name => "Project 2", :id => 2}
    before :each do
      Project.stub_chain(:enabled, :find).with(2).and_return project2
      project2.stub(:section).and_return section2
      section2.stub_chain(:projects, :enabled).and_return [project1, project2]
    end
    
    it "assigns @project" do
      get :show, :id => 2, :locale => 'en'
      assigns[:project].should == project2
    end
    
    it "assigns @section" do
      get :show, :id => 2, :locale => 'en'
      assigns[:section].should == section2
    end
    
    it "assigns @projects" do
      get :show, :id => 2, :locale => 'en'
      assigns[:projects].should == [project1, project2]
    end
    
    it "renders show view" do
      get :show, :id => 2, :locale => 'en'
      response.should render_template(:show)
    end
    
    it "renders 404 if project's section is disabled" do
      section2.stub(:enabled).and_return false
      get :show, :id => 2, :locale => 'en'
      response.should render_template("pages/404")
    end
  end
end
