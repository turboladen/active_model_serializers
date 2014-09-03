class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.belongs_to :section, index: true

      t.timestamps
    end

    create_join_table :posts, :tags
  end
end
