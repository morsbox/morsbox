class Admin::SectionsController < Admin::IndexController
  def index
    @sections = Section.sorted
  end
  
  def new
    @section = Section.new flash[:section]
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
