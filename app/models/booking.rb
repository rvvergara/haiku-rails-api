class Booking < ApplicationRecord
  belongs_to :practitioner
  belongs_to :patient

  validates :start_time, presence: true

  before_validation :check_if_slot_taken


  def confirm
    # set booking confirmed to true
    update(confirmed: true)
    # set booked column in availability record to true
    slot = corresponding_open_slot
    slot.update(booked: true)
  end

  def cancel
    # set cancelled column to true

    # set booked column in availability record to true
  end

  private

  def check_if_slot_taken
    return if corresponding_open_slot

    errors[:time_slot] << 'already taken'
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
    
  end
end
