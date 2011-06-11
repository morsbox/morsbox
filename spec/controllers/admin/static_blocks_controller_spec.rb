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
  
  describe "PUT update" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @static_block = mock_model(StaticBlock, :id => 1, :name=>"home").as_null_object
      StaticBlock.stub(:find).and_return @static_block
      @static_block.stub(:update_attributes).and_return true
    end
    
    it "finds updated static block" do
      StaticBlock.should_receive(:find).with 1
      put :update, :locale => "ru", :id => 1
    end
    
    it "updates attributes of static block" do
      @static_block.should_receive :update_attributes
      put :update, :locale => "ru", :id => 1
    end
    
    it "nullifies empty translates from param hash" do
      @static_block.should_receive(:update_attributes).with "name"=>"home","text_en"=>nil
      put :update, :locale => "ru", :id => 1, :static_block=>{:name=>"home",:text_en=>""}
    end
    
    context "when saving is successful" do
      it "sets flash[:notice]" do
        put :update, :locale => "ru", :id => 1
        flash[:notice].should_not be_empty
      end
      
      it "redirects to edit this static block if apply was passed" do
        put :update, :locale => "ru", :id => 1, :apply => "foo"
        response.should redirect_to(edit_admin_static_block_path(@static_block))
      end
      
      it "redirects to index of static blocks if apply wasn't passed" do
        put :update, :locale => "ru", :id => 1
        response.should redirect_to(admin_static_blocks_path)
      end
    end
    
    context "when saving isn't successful" do
      before :each do
        @static_block.stub(:update_attributes).and_return false
      end
      
      it "sets flash[:alert]" do
        put :update, :locale => "ru", :id => 1
        flash[:alert].should_not be_empty
      end
      
      it "redirects to edit this static block" do
        put :update, :locale => "ru", :id => 1
        response.should redirect_to(edit_admin_static_block_path(@static_block))
      end
    end
  end
  
  describe "DELETE destroy" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in Factory.create(:admin)
      @static_block = mock_model(StaticBlock, :id => 1, :name=>"home").as_null_object
      StaticBlock.stub(:find).and_return @static_block
      @static_block.stub(:destroy)
    end
    
    it "finds deleted static block" do
      StaticBlock.should_receive(:find).with 1
      delete :destroy, :locale => "ru", :id => 1
    end
    
    it "destroy static block" do
      @static_block.should_receive :destroy
      delete :destroy, :locale => "ru", :id => 1
    end
    
    it "sets flash[:notice]" do
      delete :destroy, :locale => "ru", :id => 1
      flash[:notice].should_not be_empty
    end
    
    it "redirects to index of static blocks" do
      delete :destroy, :locale => "ru", :id => 1
      response.should redirect_to(admin_static_blocks_path)
    end
  end
end
