class Recipe < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :recipe_materials
  has_many :materials, through: :recipe_materials
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
