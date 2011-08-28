class Description < ActiveRecord::Base
  include R18n::Translated
  translations :text

  has_attached_file :image, :styles => { :thumb => "100x100>" }

  belongs_to :project
  acts_as_list :scope => :project, :column => :show_order, :top_of_list => 0

  default_scope order(:show_order, "created_at DESC")
  scope :enabled, where(:enabled=>true)
end
