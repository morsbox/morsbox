class Admin::DescriptionsController < Admin::IndexController
  before_filter :find_project
  before_filter(:only => [:create, :update]){ nullify_empty_values_from_params :description }
  
  def create
    @project.descriptions.create params[:description]
    flash[:notice] = t.description.saved_successfully
    redirect_to edit_admin_project_path(@project)
  end
  
  def update
  end
  
  def destroy
  end

private
  def find_project
    @project = Project.find params[:project_id]
  end
end
