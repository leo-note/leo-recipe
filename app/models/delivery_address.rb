class DeliveryAddress < ApplicationRecord
  # アソシエーション
  belongs_to :present_order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
