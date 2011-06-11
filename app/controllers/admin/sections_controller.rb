class Admin::SectionsController < Admin::IndexController
  before_filter(:only => [:create, :update]){ nullify_empty_values_from_params :section }
  
  def index
    @admin_sections = Section.sorted
  end
  
  def new
    @section = Section.new flash[:section]
  end
  
  def create
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
    @section = Section.find params[:id]
  end
  
  def update
    @section = Section.find params[:id]
    if @section.update_attributes params[:section]
      flash[:notice] = t.section.saved_successfully
      if params[:apply]
        redirect_to edit_admin_section_path(@section)
      else
        redirect_to admin_sections_path
      end
    else
      flash[:alert] = t.section.errors_occurred
      redirect_to edit_admin_section_path(@section)
    end
  end
  
  def destroy
    @section = Section.find params[:id]
    @section.destroy
    flash[:notice] = t.section.destroyed_successfully
    redirect_to admin_sections_path
  end
end
