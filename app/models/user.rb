class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :province

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, :email, :address, presence: true
  validates :email, uniqueness: true
end
