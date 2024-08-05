class Province < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :gst, :pst, :hst, :qst, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "name", "pst", "qst", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end
end
