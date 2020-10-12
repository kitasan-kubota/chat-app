class User < ApplicationRecord
  validates :username, presence: true
  has_many :room_users
  has_many :rooms, through: :room_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
