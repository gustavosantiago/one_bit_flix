class Category < ApplicationRecord
  has_many :series
  has_many :movies

  validates :name, presence: true, uniqueness: true
end
