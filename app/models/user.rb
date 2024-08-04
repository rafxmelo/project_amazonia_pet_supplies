class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :province, optional: true
  has_many :orders, dependent: :destroy

  validates :address, presence: true, if: -> { province_id.present? }
  validates :username, :email, presence: true
  validates :email, uniqueness: true
  validates :province_id, presence: true, on: :update

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "province_id", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
end
