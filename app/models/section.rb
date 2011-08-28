class Section < ActiveRecord::Base
  include R18n::Translated
  translations :name

  validates :name_ru, :presence => true
  has_many :projects, :dependent => :nullify, :order => :show_order
  acts_as_list :column => :show_order, :top_of_list => 0

  default_scope order(:show_order, "created_at DESC")
  scope :enabled, where(:enabled=>true)
end
