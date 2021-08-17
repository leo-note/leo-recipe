class Profile < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_one :allergy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :gender
  belongs_to :family_structure
  belongs_to :taste
end
