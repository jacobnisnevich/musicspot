class AddGroupIdToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :group_id, :integer
  end
end
