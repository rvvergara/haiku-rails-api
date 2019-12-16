class AddStatusToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :status, :string, null: false, default: 'new'
    remove_column :bookings, :consumed
    remove_column :bookings, :expired
    remove_column :bookings, :cancelled
    remove_column :bookings, :rejected
    remove_column :bookings, :confirmed
  end
end
