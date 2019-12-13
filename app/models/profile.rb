class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :profilable, polymorphic: true

  validates :user, presence: true
  validates :profilable, presence: true

  delegate :owner, to: :user
end
