class SentanceSerializer < ActiveModel::Serializer
  attributes :id, :content
  belongs_to :post, serializer: PostSerializer
  belongs_to :user, serializer: UserSerializer
end
