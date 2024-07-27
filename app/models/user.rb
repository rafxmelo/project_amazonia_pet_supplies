class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province
  has_many :orders, dependent: :destroy

  validates :username, :email, :address, presence: true
  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "province_id", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
end
