require 'spec_helper'

describe Admin::SectionsController do
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
      Section.stub(:sorted).and_return [@section]
    end
    
    it "assign @section" do
      get :index, :locale => "ru"
      assigns(:sections).should == [@section]
    end
    
    it "renders index view" do
      get :index, :locale => 'ru'
      response.should render_template(:index)
    end
  end
  
  describe "GET new" do
    let(:section){mock_model(Section).as_new_record}
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      Section.stub(:new).and_return section
    end
    
    it "assigns new section to @section" do
      get :new, :locale => 'en'
      assigns[:section].should == section
    end
    
    it "creates new section from flash[:section]" do
      Section.should_receive(:new).with "name_ru"=>"Logo"
      get :new, {:locale => 'en'}, nil, {:section => {"name_ru"=>"Logo"}}
    end
    
    it "renders new template" do
      get :new, :locale => 'en'
      response.should render_template(:new)
    end
  end
end
