class Admin::SectionsController < Admin::IndexController
  def index
    @sections = Section.sorted
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
