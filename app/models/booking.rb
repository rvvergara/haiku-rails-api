class Booking < ApplicationRecord
  belongs_to :practitioner
  belongs_to :patient

  validates :start_time, presence: true

  private

  
end
