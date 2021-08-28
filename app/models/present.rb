class Present < ActiveHash::Base
  self.data = [
    { id: 1, name: '--', point: 0, image: 'present_image/gift-4669449_1920.jpg' },
    { id: 2, name: '国産フルーツジャム', point: 5, image: 'present_image/glass-bottles-4042506_1920.jpg' },
    { id: 3, name: 'パスタ３種セット', point: 10, image: 'present_image/noodles-631042_1920.jpg' },
    { id: 4, name: '季節の野菜７点セット', point: 20, image: 'present_image/vegetables-752153_1920.jpg' },
    { id: 5, name: 'フラワー柄ボウル', point: 50, image: 'present_image/plate-1141195_1920.jpg' },
    { id: 6, name: '鋳物鍋セット', point: 100, image: 'present_image/pot-555064_1920.jpg' }
  ]
  include ActiveHash::Associations
  has_many :present_orders
end
