class OrderShipping
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :phone_number, :building_name, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :city
    validates :address
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_number, length: { maximum: 11 }, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters.' }
  end

  validates :prefecture_id, numericality: { other_than: 0 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
