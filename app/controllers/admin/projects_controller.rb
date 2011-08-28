class Admin::ProjectsController < Admin::IndexController
  before_filter(:only => [:create, :update]){ nullify_empty_values_from_params :project }
  
  def index
    @admin_sections = Section.all
    session[:section_id] = params[:section_id] if params[:section_id]
    section = Section.find_by_id session[:section_id]
    if section
      @projects = section.projects
    else
      @projects = Project.all
    end
  end
  
  def new
    @admin_sections = Section.all
    options = session[:section_id] ? {:section_id => session[:section_id]} : {}
    options.merge! flash[:project] if flash[:project]
    @project = Project.new options
  end
  
  def create
    @project = Project.new params[:project]
    if @project.save
      flash[:notice] = t.project.saved_successfully
      if params[:apply]
        redirect_to edit_admin_project_path(@project)
      else
        redirect_to admin_projects_path
      end
    else
      flash[:alert] = t.project.errors_occurred + @project.errors.full_messages*", "
      flash[:project] = params[:project]
      redirect_to new_admin_project_path
    end
  end
  
  def edit
    @admin_sections = Section.all
    @project = Project.find params[:id]
    @descriptions = @project.descriptions
  end
  
  def update
    @project = Project.find params[:id]
    if @project.update_attributes params[:project]
      change_order(@project) if params[:order]
      flash[:notice] = t.project.saved_successfully
      if params[:apply]
        redirect_to edit_admin_project_path(@project)
      else
        redirect_to admin_projects_path
      end
    else
      flash[:alert] = t.project.errors_occurred + @project.errors.full_messages*", "
      redirect_to edit_admin_project_path(@project)
    end
  end
  
  def destroy
    @project = Project.find params[:id]
    @project.destroy
    flash[:notice] = t.project.destroyed_successfully
    redirect_to admin_projects_path
  end
end
