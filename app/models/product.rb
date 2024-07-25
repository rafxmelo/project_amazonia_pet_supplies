class Product < ApplicationRecord
  has_many :order_items
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_one_attached :image

  validates :name, :description, :price, :stock_quantity, presence: true

  scope :on_sale, -> { where(on_sale: true) }
  scope :newly_added, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where('created_at < ?', 3.days.ago) }

  def self.search(keyword)
    where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "stock_quantity", "updated_at","on_sale"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["categories", "image_attachment", "image_blob", "order_items", "product_categories"]
  end
end
