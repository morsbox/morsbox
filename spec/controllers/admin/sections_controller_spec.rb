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
  
  describe "POST create" do
    let(:section){mock_model(Section).as_null_object}
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      Section.stub(:new).and_return section
      section.stub(:save).and_return true
    end
    
    it "creates new section" do
      Section.should_receive(:new).with "name_ru"=>"Logo"
      post :create, :locale => "ru", :section => {"name_ru"=>"Logo"}
    end
    
    it "saves section" do
      section.should_receive :save
      post :create, :locale => "ru"
    end
    
    it "nullifies empty translates from param hash" do
      Section.should_receive(:new).with "name_ru"=>"Logo","name_en"=>nil
      post :create, :locale => "ru", :section=>{"name_ru"=>"Logo","name_en"=>""}
    end
    
    context "when saving is successful" do
      it "sets flash[:notice]" do
        post :create, :locale => "ru"
        flash[:notice].should=~ /.+/
      end
      
      it "redirects to edit this section if apply was passed" do
        post :create, :locale => "ru", :apply => "foo"
        response.should redirect_to(edit_admin_section_path(section))
      end
      
      it "redirects to index of section if apply wasn't passed" do
        post :create, :locale => "ru"
        response.should redirect_to(admin_sections_path)
      end
    end
    
    context "when saving isn't successful" do
      before :each do
        section.stub(:save).and_return false
      end
      
      it "sets flash[:alert]" do
        post :create, :locale => "ru"
        flash[:alert].should=~ /.+/
      end
      
      it "sets flash[:section] with params[:section]" do
        post :create, :locale => 'en', :section => {"name_ru"=>"Logo"}
        flash[:section].should == {"name_ru"=>"Logo"}
      end
      
      it "redirects to new section" do
        post :create, :locale => "ru"
        response.should redirect_to(new_admin_section_path)
      end
    end
  end
  
  describe "GET edit" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @section = mock_model(Section, :id => 1, :name_ru=>"Web").as_null_object
      Section.stub(:find).and_return @section
    end
    
    it "assign @section" do
      Section.should_receive(:find).with 1
      get :edit, :locale => "ru", :id => 1
      assigns(:section).should == @section
    end
    
    it "renders edit view" do
      get :edit, :locale => 'ru', :id => 1
      response.should render_template(:edit)
    end
  end
end
