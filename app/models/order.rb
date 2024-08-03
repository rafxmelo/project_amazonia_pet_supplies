# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :total_amount, :status, presence: true

  enum status: { new_order: 0, paid_order: 1, shipped: 2 }

  def add_items_from_cart(cart)
    cart.each do |id, quantity|
      begin
        product = Product.find(id)
        Rails.logger.debug "Adding product: #{product.name}, Quantity: #{quantity}, Price: #{product.price}"
        order_items.build(product: product, quantity: quantity, price: product.price)
      rescue ActiveRecord::RecordNotFound
        Rails.logger.error "Product with id #{id} not found."
      end
    end
  end

  def calculate_total_amount
    subtotal = order_items.sum { |item| item.quantity * item.price }
    Rails.logger.debug "Subtotal: #{subtotal}"
    province = user.province
    gst = subtotal * (province.gst / 100.0)
    pst = subtotal * (province.pst / 100.0)
    qst = subtotal * (province.qst / 100.0)
    self.total_amount = subtotal + gst + pst + qst
    Rails.logger.debug "Calculated total amount: #{self.total_amount}"
  end

  before_save :calculate_total_amount

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "total_amount", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user", "province"]
  end
end
