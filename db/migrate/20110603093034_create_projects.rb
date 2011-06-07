class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name_cs, :name_en, :name_ru
      t.boolean :enabled, :default => true
      t.integer :show_order, :default => 0
      t.references :section

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
