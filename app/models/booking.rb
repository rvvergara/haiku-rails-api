# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :practitioner
  belongs_to :patient

  validates :start_time, presence: true

  before_validation :check_if_slot_taken, on: [:create]

  def save_record
    return unless valid?

    save
    # When booking record is created, the booking_id in the slot should be filled and booked set to true
    slot = corresponding_open_slot
    slot.update(booked: true, booking_id: id)
    slot.save
  end

  def confirm
    return if status == 'confirmed'
    update(status: 'confirmed')
    save
  end

  def cancel
    # set cancelled column to true
    update(status: 'cancelled')
    # set booked column in availability record to true
    slot = booked_slot
    slot.update(booked: false, booking_id: nil)
    save
  end

  def reject
    # set rejected column value to true
    update(status: 'rejected')

    # set booked value in slot to false and booking_id to nil
    slot = booked_slot
    slot.update(booked: false, booking_id: nil)
    save
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
      # 'booking_id=?', id
      'practitioner_id=? AND start_time=? AND availability_date=? AND booked=?', practitioner_id, start_time, appointment_date, true
    ).first
  end
end
