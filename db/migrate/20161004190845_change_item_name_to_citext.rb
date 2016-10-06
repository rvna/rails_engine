class ChangeItemNameToCitext < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :name, :citext
  end
end
