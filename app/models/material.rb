class Material < ApplicationRecord
  # アソシエーション
  has_many :allergy_materials
  has_many :allergies, through: :allergy_materials
  has_many :recipe_materials
  has_many :recipes, through: :recipe_materials
end
