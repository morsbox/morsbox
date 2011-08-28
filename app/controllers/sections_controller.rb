class SectionsController < ApplicationController
  def show
    @section = Section.enabled.find params[:id]
    @projects = @section.projects.enabled
    @project = @projects.first
    render "projects/show"
  end
end
