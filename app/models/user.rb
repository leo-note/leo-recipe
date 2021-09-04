class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :nickname, presence: true
  # パスワード半角英字・半角数字混合入力のチェック
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  # アソシエーション
  has_one :profile
  has_many :recipes
  has_many :clips
  has_many :comments
  has_many :present_orders
  # フォロワー取得時のアソシエーション
  has_many :follows, foreign_key: 'followee_id'
  has_many :followings, through: :follows, source: :follower
  # フォロイー取得時のアソシエーション
  has_many :reverse_of_follows, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :reverse_of_followings, through: :reverse_of_follows, source: :followee
end
