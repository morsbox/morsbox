class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale_from_url
  before_filter :assign_sections
  
protected
  def assign_sections
    @sections = Section.enabled
  end

private  
  def after_sign_out_path_for resource
    admin_root_path
  end
end
