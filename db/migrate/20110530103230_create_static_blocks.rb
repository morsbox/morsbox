class CreateStaticBlocks < ActiveRecord::Migration
  def self.up
    create_table :static_blocks do |t|
      t.string :name
      t.text :text_cs, :text_en, :text_ru

      t.timestamps
    end
    add_index :static_blocks, :name, :unique => true
  end

  def self.down
    drop_table :static_blocks
  end
end
