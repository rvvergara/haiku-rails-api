class Clinic < ApplicationRecord
  belongs_to :creator, class_name: 'Practitioner'
  has_one_attached :avatar, dependent: :purge

  validates :name, :address, :category, :openning_hours, presence: true

  delegate :user, to: :creator
end
