# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :practitioner
  
  validates :availability_date, :start_time, :end_time, presence: true

  before_validation :is_valid_range?, :raise_conflict

  after_initialize :set_defaults

  private

  def set_defaults
    current_time = Tod::TimeOfDay(Time.now)
    self.availability_date = Date.today if availability_date.nil?
    self.start_time = current_time.strftime('%H:%M:%S') if start_time.nil?
    self.end_time = (current_time + 2700).strftime('%H:%M:%S') if end_time.nil?
  end

  def is_valid_range?
    return if start_time <= end_time

    errors[:time_range] << 'Start time must be earlier or same as end time.'
  end

  def has_conflict?
    same_day = Availability.where('availability_date=? AND id <> ?', availability_date, id)
    same_day.any? do |slot|
      range = slot.start_time..slot.end_time
      range.include?(start_time) || range.include?(end_time)
    end
  end

  def raise_conflict
    return unless has_conflict?

    errors[:conflict] << 'Time  slot has conflict with another record.'
  end
end
