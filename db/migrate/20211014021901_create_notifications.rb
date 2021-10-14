class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :send_id, null: false
      t.integer :receive_id, null: false
      t.integer :post_id
      t.integer :post_comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :send_id
    add_index :notifications, :receive_id
    add_index :notifications, :post_id
    add_index :notifications, :post_comment_id

  end
end
