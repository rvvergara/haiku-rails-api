# frozen_string_literal: true

class Patient < ApplicationRecord
  has_one :profile, as: :profilable, dependent: :destroy
  has_one_attached :profile_pic

  validates :first_name, presence: true
  validates :last_name, presence: true

  def create_profile(user)
    user.create_profile(profilable_type: 'Patient', profilable: self)
    save
  end
end
