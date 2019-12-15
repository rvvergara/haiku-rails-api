class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities, id: :uuid do |t|
      t.uuid :practitioner_id, null: false
      t.date :availability_date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.boolean :booked, null: false, default: false
      t.timestamps
    end
    add_index :availabilities, :practitioner_id
    add_foreign_key :availabilities, :practitioners, column: :practitioner_id
  end
end
