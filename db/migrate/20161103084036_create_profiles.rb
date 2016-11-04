class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :email
      t.string :musical_role
      t.string :interests
      t.string :other

      t.timestamps
    end
  end
end
