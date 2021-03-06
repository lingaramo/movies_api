class MovieSerializer
  extend RomanNumbers
  include FastJsonapi::ObjectSerializer

  attribute :title
  attribute :release_year do |object|
    to_roman_number(object.release_year)
  end

  has_many :casting, serializer: PersonSerializer, if: Proc.new { |record| record.casting.any? }

  has_many :directors, serializer: PersonSerializer, if: Proc.new { |record| record.directors.any? }

  has_many :producers, serializer: PersonSerializer, if: Proc.new { |record| record.producers.any? }
end
