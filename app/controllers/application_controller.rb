class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale_from_url
  before_filter :assign_sections
  around_filter :catch_exceptions
  
protected
  def assign_sections
    @sections = Section.enabled
  end
  
  def method_missing method_name, *args
    render_404
  end
  
  def render_404
    render 'pages/404', :status => 404
  end

private  
  def after_sign_out_path_for resource
    admin_root_path
  end
  
  def catch_exceptions
    yield
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
