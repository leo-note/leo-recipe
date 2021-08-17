class Taste < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '薄味が好き' },
    { id: 3, name: '濃い目が好み' },
    { id: 4, name: '辛いもの大好き' },
    { id: 5, name: '子ども舌（苦いのは嫌い・・・）' }
  ]
  include ActiveHash::Associations
  has_many :profiles
end
