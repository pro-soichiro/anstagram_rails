class RemoveIndexLikesPostId < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :posts
    remove_foreign_key :likes, :users
    remove_index :likes, column: :post_id, name: 'index_likes_on_post_id'
    remove_index :likes, column: :user_id, name: 'index_likes_on_user_id'
  end
end
