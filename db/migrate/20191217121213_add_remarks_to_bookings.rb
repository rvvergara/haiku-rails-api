class AddRemarksToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :patient_remarks, :text
    add_column :bookings, :practitioner_remarks, :text
  end
end
