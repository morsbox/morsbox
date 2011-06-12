class StaticBlock < ActiveRecord::Base
  include R18n::Translated
  validates :name, :presence => true, :uniqueness => true
  translations :text
  
  def self.get_block name
    find_by_name(name) || create(:name => name, :text_ru => "")
  end
end
