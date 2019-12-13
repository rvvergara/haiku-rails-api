class Patient < ApplicationRecord
  has_one :profile, as: :profilable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
