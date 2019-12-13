class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :profilable_id, null: false
      t.string :type

      t.timestamps
    end
    add_index :profiles, :user_id
    add_index :profiles, :profilable_id
    add_foreign_key :profiles, :users, column: :user_id
  end
end
