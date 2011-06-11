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
end
