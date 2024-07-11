class Membership < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :flights
end
