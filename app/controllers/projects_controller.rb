class ProjectsController < ApplicationController
  def show
    @project = Project.enabled.find params[:id]
    @section = @project.section
    @projects = @section.projects.enabled
  end
end