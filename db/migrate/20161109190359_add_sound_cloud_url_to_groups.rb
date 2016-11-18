class AddSoundCloudUrlToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :soundcloud_url, :string
  end
end
