class ProjectsController < ApplicationController
  def show
    @project = Project.enabled.find params[:id]
    @section = @project.section
    if @section.enabled
      @projects = @section.projects.enabled
    else
      render_404
    end
  end
end