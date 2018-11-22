class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_year, presence: true, numericality: { greater_than: 1900 }
end
