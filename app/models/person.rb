class Person < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :alias, presence: true

  has_and_belongs_to_many :as_actor, class_name: "Movie", join_table: :casting
  has_and_belongs_to_many :as_director, class_name: "Movie", join_table: :producers
  has_and_belongs_to_many :as_producer, class_name: "Movie", join_table: :directors

  before_destroy { as_actor.clear }
  before_destroy { as_director.clear }
  before_destroy { as_producer.clear }
end
