class AddAboutToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :about, :text
  end
end
