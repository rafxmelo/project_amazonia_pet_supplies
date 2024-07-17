class Province < ApplicationRecord
  has_many :users

  validates :name, :gst, :pst, :hst, presence: true
end
