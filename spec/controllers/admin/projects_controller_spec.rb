require 'spec_helper'

describe Admin::ProjectsController do
  it "redirects to sign in form, when not admin" do
    get :index, :locale => 'ru'
    response.should redirect_to(new_admin_session_path)
    get :new, :locale => 'ru'
    response.should redirect_to(new_admin_session_path)
    post :create, :locale => 'ru'
    response.should redirect_to(new_admin_session_path)
    get :edit, :locale => 'ru', :id => 1
    response.should redirect_to(new_admin_session_path)
    put :update, :locale => 'ru', :id => 1
    response.should redirect_to(new_admin_session_path)
    delete :destroy, :locale => 'ru', :id => 1
    response.should redirect_to(new_admin_session_path)
  end
    
  describe "GET index" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @section = mock_model(Section).as_null_object
      @project = mock_model(Project).as_null_object
      Project.stub(:sorted).and_return [@project]
      Section.stub(:sorted).and_return [@section]
    end
    
    it "assign @admin_sections" do
      get :index, :locale => "ru"
      assigns(:admin_sections).should == [@section]
    end
    
    it "assign @projects" do
      get :index, :locale => "ru"
      assigns(:projects).should == [@project]
    end
    
    it "renders index view" do
      get :index, :locale => 'ru'
      response.should render_template(:index)
    end
  end
end
