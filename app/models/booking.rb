# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :practitioner
  belongs_to :patient

  validates :start_time, presence: true

  before_validation :check_if_slot_taken, on: [:create]

  def save_record
    return unless valid?
    save
    attach_booking_to_availability
  end

  def confirm(params)
    return if status == 'confirmed'
    update_attributes(
      status: 'confirmed',
      practitioner_remarks: params[:practitioner_remarks],
      patient_remarks: params[:patient_remarks]
    )
    save
  end

  def cancel(params)
    return if status == 'cancelled'
    # set cancelled column to true
    update_attributes(
      status: 'cancelled',
      practitioner_remarks: params[:practitioner_remarks],
      patient_remarks: params[:patient_remarks]
    )
    reset_availability
    save
  end

  def reject(params)
    return if status == 'rejected'
    # set rejected column value to true
    update_attributes(
      status: 'rejected',
      practitioner_remarks: params[:practitioner_remarks],
      patient_remarks: params[:patient_remarks]
    )
    reset_availability
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

  def attach_booking_to_availability
    # When booking record is created, the booking_id in the slot should be filled and booked set to true
    slot = corresponding_open_slot
    slot.update(
      booked: true, 
      booking_id: id
    )
  end

  def reset_availability
    # set booked column in availability record to false
    # set booking_id back to nil
    slot = booked_slot
    slot.update_attributes(booked: false, booking_id: nil)
  end
end
