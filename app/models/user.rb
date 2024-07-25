class User < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, :email, :address, presence: true
  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "province_id", "updated_at", "username"]
  end
end
