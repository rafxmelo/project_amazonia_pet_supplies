# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :total_amount, :status, presence: true
  validates :payment_intent_id, presence: true, if: :stripe_payment?

  enum status: { new_order: 0, paid_order: 1, shipped: 2 }

  # Serialize metadata to store additional data like user_name and address
  store :metadata, accessors: [:recipient_name, :recipient_address], coder: JSON

  def needs_payment?
    status == "new_order" && !payment_intent_id
  end

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

    gst_rate = self.gst_rate || province&.gst || 0
    pst_rate = self.pst_rate || province&.pst || 0
    qst_rate = self.qst_rate || province&.qst || 0
    hst_rate = self.hst_rate || province&.hst || 0

    # Log the tax rates to debug
    Rails.logger.debug "GST Rate: #{gst_rate}, PST Rate: #{pst_rate}, QST Rate: #{qst_rate}, HST Rate: #{hst_rate}"

    # Use stored tax rates for the order
    gst = subtotal * (gst_rate / 100.0)
    pst = subtotal * (pst_rate / 100.0)
    qst = subtotal * (qst_rate / 100.0)
    hst = subtotal * (hst_rate / 100.0)

    self.total_amount = subtotal + gst + pst + qst + hst
    Rails.logger.debug "Calculated total amount: #{self.total_amount}"
  end

  def stripe_payment?
    payment_intent_id.present?
  end

  def set_current_tax_rates
    # Set current tax rates from the user's province
    if province.present?
      self.gst_rate ||= province.gst || 0
      self.pst_rate ||= province.pst || 0
      self.qst_rate ||= province.qst || 0
      self.hst_rate ||= province.hst || 0
    else
      Rails.logger.error "Province not set for order: #{self.id}"
    end
  end

  before_save :calculate_total_amount

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "status", "total_amount", "updated_at", "user_id","payment_intent_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "user", "province"]
  end
end
