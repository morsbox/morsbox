class Admin::ProjectsController < Admin::IndexController
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
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
