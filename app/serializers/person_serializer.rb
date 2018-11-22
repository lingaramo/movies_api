class PersonSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :alias

  has_many :as_actor, serializer: MovieSerializer, if: Proc.new { |record| record.as_actor.any? }
  has_many :as_director, serializer: MovieSerializer, if: Proc.new { |record| record.as_director.any? }
  has_many :as_producer, serializer: MovieSerializer, if: Proc.new { |record| record.as_producer.any? }
end
