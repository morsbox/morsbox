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
      @section.stub_chain(:projects,:sorted).and_return []
      @project = mock_model(Project).as_null_object
      Project.stub(:sorted).and_return [@project]
      Section.stub(:find_by_id).and_return nil
      Section.stub(:sorted).and_return [@section]
    end
    
    it "assign @admin_sections" do
      get :index, :locale => "ru"
      assigns(:admin_sections).should == [@section]
    end
    
    it "checks section filter" do
      Section.should_receive(:find_by_id).with '1'
      get :index, :locale => "ru", :section_id => '1'
    end
    
    context "when no section filter" do
      it "assign @projects" do
        get :index, :locale => "ru"
        assigns(:projects).should == [@project]
      end
    end
  
    context "when section filter present" do
      it "assign @projects only belonging to this section" do
        Section.stub(:find_by_id).and_return @section
        get :index, :locale => "ru", :section_id => '1'
        assigns(:projects).should == []
      end
    end
    
    it "renders index view" do
      get :index, :locale => 'ru'
      response.should render_template(:index)
    end
  end
end
