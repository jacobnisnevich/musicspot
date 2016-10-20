class AddLocationToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :location, :string
  end
end
