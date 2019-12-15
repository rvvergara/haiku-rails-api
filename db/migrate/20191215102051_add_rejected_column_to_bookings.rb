class AddRejectedColumnToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :rejected, :boolean, null: false, default: false
  end
end
