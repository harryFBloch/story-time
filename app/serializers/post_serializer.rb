class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :image_url
  belongs_to :user, serializer: UserSerializer
  belongs_to :genre, serializer: GenreSerializer

end
