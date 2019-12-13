class Practitioner < ApplicationRecord
  has_one :profile, as: :profilable
end
