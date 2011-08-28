class Admin::IndexController < ApplicationController
  before_filter :check_admin

private
  def check_admin
    redirect_to new_admin_session_path unless admin_signed_in?
  end
  
  def nullify_empty_values_from_params model_name
    (params[model_name]||{}).each{ |k,v| params[model_name][k]=nil if v.blank? }
  end

  def change_order resource
    methods = { :top => :move_to_top, :up => :move_higher,
                :down => :move_lower, :bottom => :move_to_bottom}
    resource.send methods[params[:order].to_sym]
  end
end
