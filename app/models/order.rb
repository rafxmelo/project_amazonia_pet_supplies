class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :total_amount, :status, presence: true

  def add_items_from_cart(cart)
    cart.each do |id, quantity|
      product = Product.find(id)
      order_items.build(product: product, quantity: quantity, price: product.price)
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "total_amount", "updated_at", "user_id"]
  end
end
