class AddBookingIdToAvailability < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :booking_id, :uuid
    add_index :availabilities, :booking_id
  end
end
