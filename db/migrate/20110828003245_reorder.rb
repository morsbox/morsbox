class Reorder < ActiveRecord::Migration
  def self.reorder model
    resources = model.all
    resources.each_index{ |i| resources[i].update_attributes :show_order => i }
  end

  def self.up
    reorder Section
    Section.all.each{ |section| reorder section.projects }
    Project.all.each{ |section| reorder section.descriptions }
  end

  def self.down
  end
end
