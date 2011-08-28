module Admin::IndexHelper
  def link_to_toggle resourse_or_array
    resourse = extract_resource resourse_or_array
    caption = resourse.enabled ? image_tag("on.png") : image_tag("off.png")
    query_hash = {ActiveModel::Naming.singular(resourse) => {:enabled => !resourse.enabled}}
    link_to caption, polymorphic_path(([:admin]<<resourse_or_array).flatten,query_hash),
            :method => :put
  end
  
  def sort_links resourse_or_array
    resourse = extract_resource resourse_or_array
    output = ""
    output << link_to(image_tag("top.png"), polymorphic_path(([:admin]<<resourse_or_array).flatten, :order => :top), :method => :put)
    output << link_to(image_tag("up.png"), polymorphic_path(([:admin]<<resourse_or_array).flatten, :order => :up), :method => :put)
    output << "<span class='show_order'>#{resourse.show_order}</span>"
    output << link_to(image_tag("down.png"), polymorphic_path(([:admin]<<resourse_or_array).flatten, :order => :down), :method => :put)
    output << link_to(image_tag("bottom.png"), polymorphic_path(([:admin]<<resourse_or_array).flatten, :order => :bottom), :method => :put)
    output.html_safe
  end
  
  def extract_resource resourse_or_array
    resourse_or_array.is_a?(Array) ? resourse_or_array.last : resourse_or_array
  end
end
