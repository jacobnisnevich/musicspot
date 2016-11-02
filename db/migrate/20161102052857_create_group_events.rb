class CreateGroupEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :group_events do |t|
      t.integer :group_id
      t.integer :event_id

      t.timestamps
    end
  end
end
