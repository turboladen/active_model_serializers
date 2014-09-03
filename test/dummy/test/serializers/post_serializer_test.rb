require 'test_helper'
#require 'active_model/serializer'

class PostSerializerTest < ActiveSupport::TestCase
  def setup
    @serializer = ArraySerializer.new([posts(:one), posts(:two)], root: 'posts')
  end

  # from unit/active_model/array_serializer/except_test.rb
  def test_array_serializer_pass_except_to_items_serializers
    array = [posts(:one), posts(:two)]
    serializer = ArraySerializer.new(array, except: [:body])

    expected = [{ title: 'N1' },
      { name: 'N2' }]

    assert_equal expected, serializer.serializable_array
  end

  # from unit/active_model/array_serializer/meta_test.rb
  def test_meta
    @serializer.meta = { total: 10 }

    assert_equal({
      'posts' => [
        {
          title: 'Name 1',
          body: 'Description 1'
        }, {
        title: 'Name 2',
        body: 'Description 2'
      }
      ],
      meta: {
        total: 10
      }
    }, @serializer.as_json)
  end

  # from unit/active_model/array_serializer/meta_test.rb
  def test_meta_using_meta_key
    @serializer.meta_key = :my_meta
    @serializer.meta     = { total: 10 }

    assert_equal({
      'posts' => [
        {
          title: 'T1',
          body: 'B1'
        }, {
        title: 'T2',
        body: 'B2'
      }
      ],
      my_meta: {
        total: 10
      }
    }, @serializer.as_json)
  end

  # from unit/active_model/array_serializer/only_test.rb
  def test_array_serializer_pass_only_to_items_serializers
    array = [posts(:one, comments: [comments(:one)]),
      posts(:two, comments: [comments(:two)])]
    serializer = ArraySerializer.new(array, only: [:title])

    expected = [{ title: 'T1' },
      { title: 'T2' }]

    assert_equal expected, serializer.serializable_array
  end




end
