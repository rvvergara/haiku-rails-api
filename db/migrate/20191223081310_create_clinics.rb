class CreateClinics < ActiveRecord::Migration[5.2]
  def change
    create_table :clinics, id: :uuid do |t|
      t.string :avatar
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :category
      t.string :openning_hours
      t.uuid :creator_id

      t.timestamps
    end
    add_index :clinics, :name
    add_index :clinics, :creator_id
  end
end
