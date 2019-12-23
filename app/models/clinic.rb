class Clinic < ApplicationRecord
  belongs_to :creator, class_name: 'Practitioner'

  validates :name, :address, :category, :openning_hours, presence: true
end
