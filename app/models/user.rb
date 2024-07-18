class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :province

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, :email, :address, presence: true
  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "province_id", "updated_at", "username"]
  end
end
