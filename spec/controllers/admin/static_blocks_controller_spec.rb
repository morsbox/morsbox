require 'spec_helper'

describe Admin::StaticBlocksController do
  it "redirects to sign in form, when not admin" do
    get :index, :locale => 'ru'
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
      @static_block = mock_model(StaticBlock, :id => 1, :name=>"home").as_null_object
      StaticBlock.stub(:all).and_return [@static_block]
    end
    
    it "assign @static_blocks" do
      get :index, :locale => "ru"
      assigns(:static_blocks).should == [@static_block]
    end
    
    it "renders index view" do
      get :index, :locale => 'ru'
      response.should render_template(:index)
    end
  end
  
  describe "GET edit" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @static_block = mock_model(StaticBlock, :id => 1, :name=>"home").as_null_object
      StaticBlock.stub(:find).and_return @static_block
    end
    
    it "assign @static_block" do
      StaticBlock.should_receive(:find).with 1
      get :edit, :locale => "ru", :id => 1
      assigns(:static_block).should == @static_block
    end
    
    it "renders edit view" do
      get :edit, :locale => 'ru', :id => 1
      response.should render_template(:edit)
    end
  end
end
