# app/models/product.rb
class Product < ApplicationRecord
  has_many :order_items
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :on_sale, -> { where(on_sale: true) }
  scope :newly_added, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where('created_at < ?', 3.days.ago) }

  def self.search(keyword)
    where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "stock_quantity", "updated_at", "on_sale"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "image_attachment", "image_blob", "order_items", "product_categories"]
  end

  def resize_image(image)
    begin
      Rails.logger.debug "Resizing image with variant resize: '300x300'"
      image.variant(resize: "300x300").processed
    rescue => e
      Rails.logger.error "Image processing error: #{e.message}"
      nil
    end
  end
end
