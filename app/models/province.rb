class Province < ApplicationRecord
  has_many :users

  validates :name, :gst, :pst, :hst, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "name", "pst", "updated_at"]
  end
end
