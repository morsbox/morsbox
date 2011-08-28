class Project < ActiveRecord::Base
  include R18n::Translated
  translations :name
  
  validates :name_ru, :presence => true
  belongs_to :section
  has_many :descriptions, :dependent => :destroy, :order => :show_order
  acts_as_list :scope => :section, :column => :show_order, :top_of_list => 0

  default_scope order(:section_id, :show_order, "created_at DESC")
  scope :enabled, where(:enabled=>true)
end
