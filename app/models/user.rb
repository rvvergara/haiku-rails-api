# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true
  delegate :profilable, to: :profile, allow_nil: true

  has_one :profile, foreign_key: :user_id, dependent: :destroy

  delegate :first_name, :last_name, to: :profile
  delegate :profilable, to: :profile
  delegate :bookings, to: :profilable
end
