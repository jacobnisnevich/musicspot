class AddYoutubeUrlToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :youtube_url, :string
  end
end
