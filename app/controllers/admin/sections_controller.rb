class Admin::SectionsController < Admin::IndexController
  def index
    @sections = Section.sorted
  end
  
  def new
    @section = Section.new flash[:section]
  end
  
  def create
    (params[:section]||{}).each{ |k,v| params[:section][k]=nil if v.blank? }
    @section = Section.new params[:section]
    if @section.save
      flash[:notice] = t.section.saved_successfully
      if params[:apply]
        redirect_to edit_admin_section_path(@section)
      else
        redirect_to admin_sections_path
      end
    else
      flash[:alert] = t.section.errors_occurred
      flash[:section] = params[:section]
      redirect_to new_admin_section_path
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
