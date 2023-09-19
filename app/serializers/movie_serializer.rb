class MovieSerializer < ActiveModel::Serializer
  attributes :id,:name
  has_many :shows
  # def posters
  #   object.poster.url 
  # end
end
