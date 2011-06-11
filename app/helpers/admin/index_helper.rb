module Admin::IndexHelper
  def link_to_toggle resourse_or_array
    resourse = resourse_or_array.is_a?(Array) ? resourse_or_array.last : resourse_or_array
    caption = resourse.enabled ? t.admin.enabled : t.admin.disabled
    query_hash = {ActiveModel::Naming.singular(resourse) => {:enabled => !resourse.enabled}}
    link_to caption, polymorphic_path(([:admin]<<resourse_or_array).flatten,query_hash),
            :method => :put
  end
end
