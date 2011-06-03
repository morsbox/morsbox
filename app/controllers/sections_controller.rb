class SectionsController < ApplicationController
  def show
    @section = Section.enabled.find params[:id]
    @projects = @section.projects.enabled
  end
end
