class Practitioner < ApplicationRecord
  has_one :profile, as: :profilable, dependent: :destroy
  has_one_attached :profile_pic

  def create_profile(user)
    user.create_profile(profilable_type: 'Practitioner', profilable: self)
    save
  end
end
