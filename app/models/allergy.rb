class Allergy < ApplicationRecord
  # アソシエーション
  belongs_to :profile
  has_many :allergy_materials
  has_many :materials, through: :allergy_materials
end
