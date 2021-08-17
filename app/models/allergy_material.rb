class AllergyMaterial < ApplicationRecord
  # アソシエーション
  belongs_to :allergy
  belongs_to :material
end
