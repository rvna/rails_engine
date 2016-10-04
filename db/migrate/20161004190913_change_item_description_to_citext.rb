class ChangeItemDescriptionToCitext < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :description, :citext
  end
end
