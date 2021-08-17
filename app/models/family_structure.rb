class FamilyStructure < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '１人暮らし' },
    { id: 3, name: '２人暮らし' },
    { id: 4, name: '３〜４人暮らし' },
    { id: 5, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :profiles
end
