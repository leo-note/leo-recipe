class RecipeMaterial < ApplicationRecord
  # アソシエーション
  belongs_to :recipe
  belongs_to :material
end
