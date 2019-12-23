class CreateClinics < ActiveRecord::Migration[5.2]
  def change
    create_table :clinics, id: :uuid do |t|
      t.string :avatar
      t.string :name, null: false
      t.string :address, null: false
      t.string :postal_code, null: false, default: ''
      t.string :category, null: false, default: ''
      t.string :openning_hours, array: true, default: []
      t.uuid :creator_id, null: false

      t.timestamps
    end
    add_index :clinics, :name
    add_index :clinics, :creator_id
  end
end
