class Booking < ApplicationRecord
  belongs_to :practitioner
  belongs_to :patient

  validates :start_time, presence: true

  before_validation :check_if_slot_taken

  def save_record
    return unless self.valid?
    save
    # When booking record is created, the booking_id in the slot should be filled and booked set to true
    slot = corresponding_open_slot
    slot.update(booking_id: id, booked: true)
  end

  def confirm
    # set booking confirmed to true
    update(confirmed: true)
  end

  def cancel
    # set cancelled column to true
    update(cancelled: true)
    # set booked column in availability record to true
    slot = booked_slot
    slot.update(booked: false, booking_id: nil)
  end

  def reject
    # set rejected column value to true
    update(rejected: true)

    # set booked value in slot to false and booking_id to nil
    slot = booked_slot
    slot.update(booked: false, booking_id: nil)
  end
  
  private

  def check_if_slot_taken
    return if corresponding_open_slot

    errors[:time_slot] << 'unavailable'
  end

  def corresponding_open_slot
    availabilities = Availability.where(
      'practitioner_id=? AND availability_date=? AND start_time<=? AND end_time>=? AND booked=?',
      practitioner_id,
      appointment_date,
      start_time,
      start_time,
      false
    )
    availabilities[0]
  end

  def booked_slot
    Availability.where(
      'booking_id=?', id
    ).first
  end
end
