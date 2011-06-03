class CreateDescriptions < ActiveRecord::Migration
  def self.up
    create_table :descriptions do |t|
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      
      t.text :text_cs, :text_en, :text_ru
      t.boolean :enabled, :default => true
      t.integer :show_order, :default => 0
      
      t.references :project
      
      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
