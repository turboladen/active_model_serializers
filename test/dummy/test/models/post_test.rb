require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
  end

  def test_serialization_embedding_objects
    post_serializer = PostSerializer.new(@post)

    assert_equal({
      'post' => {
        title: 'N1', body: 'B1',
        comments: [{ body: 'what a dumb post', tags: [{ name: 'happy' }, { name: 'whiny' }] },
          { body: 'i liked it', tags: [{:name=>"happy"}, {:name=>"short"}] }],
        tags: [{ name: 'short' }, { name: 'whiny' }],
        section: { 'name' => 'ruby' }
      }
    }, post_serializer.as_json)
  end

  def test_serialization_embedding_ids
    post_serializer = PostSerializer.new(@post)

    embed(PostSerializer, embed: :ids) do
      assert_equal({
        'post' => {
          title: 'New post', body: 'A body!!!',
          'comment_ids' => [1, 2],
          'tag_ids' => [1, 2],
          'section_id' => 1
        }
      }, post_serializer.as_json)
    end
  end

  def test_serialization_embedding_ids_including_in_root
    post_serializer = PostSerializer.new(@post)

    embed(PostSerializer, embed: :ids, embed_in_root: true) do
      embed(CommentSerializer, embed: :ids, embed_in_root: true) do
        assert_equal({
          'post' => {
            title: 'New post', body: 'A body!!!',
            'comment_ids' => [1, 2],
            'tag_ids' => [1, 2],
            'section_id' => 1
          },
          comments: [{ body: 'what a dumb post', 'tag_ids' => [3, 2] },
            { body: 'i liked it', 'tag_ids' => [3, 1] }],
          tags: [{ name: 'happy' }, { name: 'whiny' }, { name: 'short' }],
          'sections' => [{ 'name' => 'ruby' }]
        }, post_serializer.as_json)
      end
    end
  end

  private

  def embed(serializer_class, options = {})
    old_assocs = Hash[serializer_class._associations.to_a.map { |(name, association)| [name, association.dup] }]

    serializer_class._associations.each_value do |association|
      association.embed = options[:embed]
      association.embed_in_root = options[:embed_in_root]
    end

    yield
  ensure
    serializer_class._associations = old_assocs
  end
end
