class Admin::ProjectsController < Admin::IndexController
  before_filter(:only => [:create, :update]){ nullify_empty_values_from_params :project }
  
  def index
    @admin_sections = Section.sorted
    section = Section.find_by_id params[:section_id]
    if section
      @projects = section.projects.sorted
    else
      @projects = Project.sorted
    end
  end
  
  def new
    @admin_sections = Section.sorted
    @project = Project.new flash[:project]
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
      flash[:alert] = t.project.errors_occurred
      flash[:project] = params[:project]
      redirect_to new_admin_project_path
    end
  end
  
  def edit
    @admin_sections = Section.sorted
    @project = Project.find params[:id]
  end
  
  def update
    @project = Project.find params[:id]
    if @project.update_attributes params[:project]
      flash[:notice] = t.project.saved_successfully
      if params[:apply]
        redirect_to edit_admin_project_path(@project)
      else
        redirect_to admin_projects_path
      end
    else
      flash[:alert] = t.project.errors_occurred
      redirect_to edit_admin_project_path(@project)
    end
  end
  
  def destroy
  end
end
