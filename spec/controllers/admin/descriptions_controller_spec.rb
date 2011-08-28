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
      @descriptions.stub_chain(:create, :move_to_top)
    end
    
    it "finds project" do
      Project.should_receive(:find).with 1
      post :create, :locale => "ru", :project_id => 1
    end
    
    it "creates new description" do
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
      flash[:notice].should_not be_empty
    end
    
    it "redirects to edit project" do
      post :create, :locale => "ru", :project_id => 1
      response.should redirect_to(edit_admin_project_path(@project))
    end
  end
  
  describe "PUT update" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @project = mock_model(Project).as_null_object
      Project.stub(:find).and_return @project
      @description = mock_model(Description).as_null_object
      @project.stub(:descriptions, :find).and_return @description
      @description.stub(:update_attributes)
    end
    
    it "finds project" do
      Project.should_receive(:find).with 1
      put :update, :locale => "ru", :project_id => 1, :id => 10
    end
    
    it "updates description" do
      @description.should_receive(:update_attributes).with "text_ru"=>"I See You"
      put :update, :locale => "ru", :project_id => 1,
          :description => {"text_ru"=>"I See You"}, :id => 10
    end
 
    it "nullifies empty translates from param hash" do
      @description.should_receive(:update_attributes).with "text_ru"=>"I See You",
                                                           "text_en"=>nil
      put :update, :locale => "ru", :project_id => 1,
          :description=>{"text_ru"=>"I See You","text_en"=>""}, :id => 10
    end
    
    it "sets flash[:notice]" do
      put :update, :locale => "ru", :project_id => 1, :id => 10
      flash[:notice].should_not be_empty
    end
    
    it "redirects to edit project" do
      put :update, :locale => "ru", :project_id => 1, :id => 10
      response.should redirect_to(edit_admin_project_path(@project))
    end
  end
  
  describe "DELETE destroy" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @project = mock_model(Project).as_null_object
      Project.stub(:find).and_return @project
      @description = mock_model(Description).as_null_object
      @project.stub(:descriptions, :find).and_return @description
      @description.stub(:destroy)
    end
    
    it "finds project" do
      Project.should_receive(:find).with 1
      delete :destroy, :locale => "ru", :project_id => 1, :id => 10
    end
    
    it "destroys project" do
      @description.should_receive :destroy
      delete :destroy, :locale => "ru", :project_id => 1, :id => 10
    end
    
    it "sets flash[:notice]" do
      delete :destroy, :locale => "ru", :project_id => 1, :id => 10
      flash[:notice].should_not be_empty
    end
    
    it "redirects to index of projects" do
      delete :destroy, :locale => "ru", :project_id => 1, :id => 10
      response.should redirect_to(edit_admin_project_path(@project))
    end
  end
end
