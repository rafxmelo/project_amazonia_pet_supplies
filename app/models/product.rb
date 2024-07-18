class Product < ApplicationRecord
  has_many :order_items
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_one_attached :image

  validates :name, :description, :price, :stock_quantity, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "stock_quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "image_attachment", "image_blob", "order_items", "product_categories"]
  end
end
