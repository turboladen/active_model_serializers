class PostSerializer < ActiveModel::Serializer
  attributes :title, :body
  has_one :section
  has_many :comments, :tags
end
