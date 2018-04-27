class House < ApplicationRecord
  has_many :houses_users, dependent: :destroy
  has_many :users, through: :houses_users
  has_many :chores, dependent: :destroy
end
