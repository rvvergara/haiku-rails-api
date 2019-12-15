# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :profilable, polymorphic: true

  validates :user, presence: true
  validates :profilable, presence: true

  delegate :first_name, to: :profilable
  delegate :last_name, to: :profilable

  def data
    profilable
  end
end
