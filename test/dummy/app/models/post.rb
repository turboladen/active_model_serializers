class Post < ActiveRecord::Base
  belongs_to :section
  has_many :comments
  has_and_belongs_to_many :tags, join_table: 'posts_tags'
end
