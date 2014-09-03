class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :post, index: true

      t.timestamps
    end

    create_join_table :comments, :tags
  end
end
