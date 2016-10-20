class AddUserIdToMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :user_id, :integer
  end
end
