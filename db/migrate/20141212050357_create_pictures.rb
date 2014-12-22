class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string :link
      t.string :description


      t.timestamps
    end
    add_index :pictures, [:user_id, :created_at]
  end
end
