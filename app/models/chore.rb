class Chore < ApplicationRecord
  belongs_to :house
  validates_presence_of :description
end
