class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "category_id", "product_id", "updated_at"]
  end
end
