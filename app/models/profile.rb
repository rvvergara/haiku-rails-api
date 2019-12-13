class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :profilable, polymorphic: true
  has_one_attached :profile_pic

  validates :user, presence: true
  validates :profilable, presence: true

  delegate :first_name, to: :profilable
  delegate :last_name, to: :profilable

  def self.practitioners
    where(profilable_type: "Practitioner")
  end

  def self.patients
    where(profilable_type: "Patient")
  end

  def data
    profilable
  end
end
