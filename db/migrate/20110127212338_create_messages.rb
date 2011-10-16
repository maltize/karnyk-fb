class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :fb_user_id
      t.string :target_fb_user_id
      t.text :body
      t.integer :status

      t.timestamps
    end

    add_index :messages, :fb_user_id
    add_index :messages, :target_fb_user_id
    add_index :messages, :status
  end

  def self.down
    drop_table :messages
  end
end
