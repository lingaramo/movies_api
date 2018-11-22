class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_year, presence: true, numericality: { greater_than: 1900 }

  has_and_belongs_to_many :casting, class_name: "Person", join_table: :casting
  has_and_belongs_to_many :directors, class_name: "Person", join_table: :directors
  has_and_belongs_to_many :producers, class_name: "Person", join_table: :producers

  before_destroy { casting.clear }
  before_destroy { directors.clear }
  before_destroy { producers.clear }
end
