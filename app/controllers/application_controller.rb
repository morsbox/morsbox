class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale_from_url
  before_filter :assign_sections
  
protected
  def assign_sections
    @sections = Section.enabled
  end
end
