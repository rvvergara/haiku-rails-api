class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings, id: :uuid do |t|
      t.boolean :confirmed, null: false, default: false
      t.time :start_time, null: false
      t.uuid :patient_id, null: false
      t.uuid :practitioner_id, null: false
      t.boolean :consumed, null: false, default: false
      t.boolean :expired, null: false, default: false
      t.boolean :cancelled, null: false, default: false

      t.timestamps
    end
    add_index :bookings, :practitioner_id
    add_index :bookings, :patient_id
    add_foreign_key :bookings, :patients, column: :patient_id
    add_foreign_key :bookings, :practitioners, column: :practitioner_id
  end
end
