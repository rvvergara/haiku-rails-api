# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :practitioner

  validates :availability_date, :start_time, :end_time, presence: true

  after_initialize do
    self.availability_date = Date.today
    self.start_time = Time.now
    self.end_time = Time.now + 2700
  end
end
