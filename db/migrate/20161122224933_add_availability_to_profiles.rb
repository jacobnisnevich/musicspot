class AddAvailabilityToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :availability, :text
  end
end
