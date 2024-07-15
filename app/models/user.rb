class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_many :groups
  has_many :memberships
  has_many :groups, through: :memberships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
