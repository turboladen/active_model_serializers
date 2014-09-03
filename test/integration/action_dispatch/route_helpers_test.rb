require 'test_helper'
require 'test_app'
require 'action_dispatch/railtie'


module ActiveModel
  class Serializer
    class RouteHelpersTest < ActionDispatch::IntegrationTest
      def setup
        post = Post.new({ name: 'Name 1', description: 'Description 1', comments: 'Comments 1' })
        @post_serializer = PostSerializer.new(post)
        #p TestApp.routes.methods
        #p TestApp.routes.named_routes.names
        p TestApp.routes.named_routes.helpers
      end

      def test_things
        puts "@prof ser methods: #{@post_serializer.methods}"
        puts "@prof serializer #{@post_serializer.posts_path}"
      end
    end
  end
end
