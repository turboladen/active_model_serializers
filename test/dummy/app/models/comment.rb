class Comment < ActiveRecord::Base
  belongs_to :post
  has_and_belongs_to_many :tags
end
