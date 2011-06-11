require 'spec_helper'

describe Admin::DescriptionsController do
  it "redirects to sign in form, when not admin" do
    post :create, :locale => 'ru', :project_id => 1
    response.should redirect_to(new_admin_session_path)
    put :update, :locale => 'ru', :project_id => 1, :id => 1
    response.should redirect_to(new_admin_session_path)
    delete :destroy, :locale => 'ru', :project_id => 1, :id => 1
    response.should redirect_to(new_admin_session_path)
  end
  
  describe "POST create" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @project = mock_model(Project).as_null_object
      Project.stub(:find).and_return @project
      @descriptions = mock(:descriptions)
      @project.stub(:descriptions).and_return @descriptions
      @descriptions.stub(:create)
    end
    
    it "fins project" do
      Project.should_receive(:find).with 1
      post :create, :locale => "ru", :project_id => 1
    end
    
    it "creates new project" do
      @descriptions.should_receive(:create).with "text_ru"=>"I See You"
      post :create, :locale => "ru", :project_id => 1,
           :description => {"text_ru"=>"I See You"}
    end
 
    it "nullifies empty translates from param hash" do
      @descriptions.should_receive(:create).with "text_ru"=>"I See You",
                                                        "text_en"=>nil
      post :create, :locale => "ru", :project_id => 1,
           :description=>{"text_ru"=>"I See You","text_en"=>""}
    end
    
    it "sets flash[:notice]" do
      post :create, :locale => "ru", :project_id => 1
      flash[:notice].should=~ /.+/
    end
    
    it "redirects to edit project" do
      post :create, :locale => "ru", :project_id => 1
      response.should redirect_to(edit_admin_project_path(@project))
    end
  end
end
