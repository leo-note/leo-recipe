class PresentOrder < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_one :delivery_address
end
