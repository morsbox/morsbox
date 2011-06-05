class CreateContactMessages < ActiveRecord::Migration
  def self.up
    create_table :contact_messages do |t|
      t.string :name, :email, :phone
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :contact_messages
  end
end
