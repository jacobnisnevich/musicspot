class AddGroupIdToAnnouncements < ActiveRecord::Migration[5.0]
  def change
    add_column :announcements, :group_id, :integer
  end
end
