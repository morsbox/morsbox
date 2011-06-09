class Admin::ProjectsController < Admin::IndexController
  def index
    @projects = Project.sorted
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
