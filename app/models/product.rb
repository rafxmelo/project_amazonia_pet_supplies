class Product < ApplicationRecord
  has_many :order_items
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_one_attached :image

  validates :name, :description, :price, :stock_quantity, presence: true
end
