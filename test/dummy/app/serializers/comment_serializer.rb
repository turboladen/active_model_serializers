class CommentSerializer < ActiveModel::Serializer
  attributes :body
  has_one :post
  has_many :tags
end
