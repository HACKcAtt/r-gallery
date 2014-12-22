class AddColumnToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :hidden, :boolean
  end
end
