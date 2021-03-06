class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_shipping

  validates :name, :image, :description, :category, :status, :delivery_fee, :prefecture, :days_shipping, presence: true

  validates :category_id, :status_id, :delivery_fee_id, :days_shipping_id, numericality: { other_than: 1 }

  validates :prefecture_id, numericality: { other_than: 0 }

  validates :price, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters.' }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
