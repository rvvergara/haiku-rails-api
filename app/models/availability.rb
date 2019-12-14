# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :practitioner

  validates :availability_date, :start_time, :end_time, presence: true

  before_validation :raise_conflict

  after_initialize do
    self.availability_date = Date.today
    self.start_time = Time.now.strftime('%H:%M:%S')
    self.end_time = (Time.now + 2700).strftime('%H:%M:%S')
  end

  private

  def has_conflict?
    Availability.where(
      'availability_date = :date AND end_time < :start_time ',
      date: availability_date,
      start_time: start_time
    )
  end

  def raise_conflict
    return unless has_conflict?

    errors.add(:end_time, :self, message: 'Conflicts with another availability slot.')
  end
end
