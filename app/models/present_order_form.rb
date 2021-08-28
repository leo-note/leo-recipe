class PresentOrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :present_id,
                :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :prefecture_id,
                :city, :address, :building_name, :phone_number

  # 必須チェック
  with_options presence: true do
    validates :user_id
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
  end
  # prefecture_id 半角数字以外・「---」の時は保存できない
  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
  end
  # name 全角入力のチェック
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :first_name
    validates :last_name
  end
  # name_kana 全角カタカナ入力のチェック
  with_options format: { with: /\A[ァ-ヶー]+\z/ } do
    validates :first_name_kana
    validates :last_name_kana
  end
  # postal_code 「xxx-xxxx」の半角文字列以外は保存できない
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  # phone_number 10桁以上11桁以内の半角数値以外は登録できない
  validates :phone_number, length: { in: 10..11 }, numericality: true

  # present_idのバリデーションチェック
  validate :present_check
  def present_check
    # presenceチェック
    if present_id.nil?
      errors.add(:present, "can't be blank")
      return
    end

    # numericチェック
    if (present_id.to_s).match(/\A[0-9]+\z/).nil?
      errors.add(:present, "is not a number")
      return
    end

    # 1は登録できない
    if present_id == 1
      errors.add(:present, "must be other than 1")
      return
    end

    if !user_id.nil?
      present = Present.find(present_id)
      user = User.find(user_id)

      # 投稿したレシピが足りていない場合は申し込みできない
      recipes = user.recipes
      point = present.point
      if point > recipes.length
        errors.add(:present, "このプレゼント応募には#{point}投稿が必要です")
        return
      end

      # 申し込み済みのプレゼントは申し込みできない
      present_orders = user.present_orders
      present_orders.each do |order|
        if present.id == order.present_id
          errors.add(:present, "申し込み済のプレゼントです。受け取りは１つにつき１回までです")
        end
      end
    end
  end

  def save
    present_order = PresentOrder.create(user_id: user_id, present_id: present_id)
    DeliveryAddress.create(last_name: last_name, first_name: first_name, first_name_kana: first_name_kana,
                           last_name_kana: last_name_kana, postal_code: postal_code, prefecture_id: prefecture_id,
                           city: city, address: address, building_name: building_name, phone_number: phone_number, 
                           present_order_id: present_order.id)
  end
end
