class Recipe < ApplicationRecord
  require 'romaji/core_ext/string'

  # アソシエーション
  belongs_to :user
  has_many :recipe_materials
  has_many :materials, through: :recipe_materials
  has_one_attached :image
  has_many :clips
  has_many :comments
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
