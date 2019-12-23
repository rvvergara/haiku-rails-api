# frozen_string_literal: true

class Practitioner < ApplicationRecord
  has_one :profile, as: :profilable, dependent: :destroy
  has_one_attached :profile_pic, dependent: :purge
  has_many :availabilities, foreign_key: :practitioner_id
  has_many :bookings, foreign_key: :practitioner_id
  has_many :appointment_setters, through: :bookings, source: :patient
  has_many :created_clinics, foreign_key: :creator_id, class_name: 'Clinic'

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :user, to: :profile

  def create_profile(user)
    user.create_profile(profilable_type: 'Practitioner', profilable: self)
    save
  end
end
