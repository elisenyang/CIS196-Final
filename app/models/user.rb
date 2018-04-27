require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  has_many :houses_users, dependent: :destroy
  has_many :houses, through: :houses_users
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :first_name_cap
  validate :last_name_cap

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  private

  def first_name_cap
    errors.add(:first_name, 'must be capitalized') unless !first_name.nil? && first_name.capitalize == first_name
  end

  def last_name_cap
    errors.add(:last_name, 'must be capitalized') unless !last_name.nil? && last_name.capitalize == last_name
  end
end
