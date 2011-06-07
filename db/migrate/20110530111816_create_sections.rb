class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :name_cs, :name_en, :name_ru
      t.boolean :enabled, :default => true
      t.integer :show_order, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
